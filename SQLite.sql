CREATE TABLE appleStore_description_combined AS 
 Select * from appleStore_description1
  UNION ALL
 Select * from appleStore_description2
  UNION ALL
 Select * from appleStore_description3
  UNION ALL
 Select * from appleStore_description4
  --check for number of unique apps in both the tables--
  select count(DISTINCT(id)) from AppleStore
   select count(DISTINCT(id)) from appleStore_description_combined
   
  -- check for any missing value in key field--
  select count(*) as NULLVALUES from 
  AppleStore where track_name IS NULL or prime_genre is NULL or user_rating is NULL
  
  --no null or missing values in applestore decription table as well--
    select count(*) as NULLVALUES from 
  appleStore_description_combined where id IS NULL 
  
 --now to chekc which catagory of app people prefer the most, we can check it by getting the count of counts of differnt genresAppleStore
  Select prime_genre, count(prime_genre) as genre_count from AppleStore
  group by(prime_genre) 
  order by genre_count desc
  limit 10
  
  --to know what average rating has each genre--
  Select prime_genre, AVG(user_rating) as avg_rating from AppleStore
  group by(prime_genre) 
  order by avg_rating 
  
  -- getting the meaningful insights from the data demo
  -- to know whether the paid apps have higher rating than free apps
  select AVG(user_rating) as avg_rating, 
  		case 
  			when price>0 then 'Paid'
            else 'Free'
            end as app_type
 		from AppleStore
        GROUP by app_type
        order by avg_rating
  
  --to know if the apps supporting higher number of languages have higher rating 
  select CASE
  		when lang_num<10 then 'low'
        when lang_num BETWEEN 10 and 20 then 'medium'
        when lang_num> 20 then 'high'
        end as total_lang,
        avg(user_rating) as avg_rating 
        from AppleStore
 GROUP by(total_lang) 
 order by(avg_rating)
 --it signifies that having more supported languages doesnt always helo get higher rating
 
 -- to chekc the apps with the lowest rating to work on the improvement areas
 select prime_genre, avg(user_rating) as avg_rating
 from AppleStore 
 group by(prime_genre)
 order by avg_rating
 limit 10
 
-- to know if the length of the app description has any relation with the user rating
select avg(user_rating) as avg_rating,
Case when b.app_desc<500 then 'low'
	 when b.app_desc BETWEEN 500 and 800 then 'Medium'
     else 'Long'
    end as app_description
from 
AppleStore as a inner join appleStore_description_combined as b 
on a.id=b.id
group by(app_description)
order by(avg_rating)
 
 --highest rating app from each genre
 select prime_genre, track_name, user_rating FROM
 (SELECT prime_genre, track_name, user_rating, 
  RANK() over (Partition by prime_genre order by user_rating desc, rating_count_tot desc) as rank 
  from AppleStore)
  as a 
  where a.rank=1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
  
  
  
  
  
  
  
  