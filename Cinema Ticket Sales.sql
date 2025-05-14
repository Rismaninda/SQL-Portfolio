select * from cinema_hall_ticket_sales chts 
limit 10;

-- Genre Favorite
select "Movie_Genre",count("Movie_Genre") as total
from cinema_hall_ticket_sales chts 
group by "Movie_Genre" 
order by 2 desc;

-- Revenue for each movie--
select "Movie_Genre",sum("Ticket_Price") as total_revenue
from cinema_hall_ticket_sales chts
group by 1
order by 2 desc;

-- Age group
select case 
	when "Age" <=10 then '10s'
	when "Age" <=20 then '20s'
	when "Age" <=30 then '30s'
	when "Age" <=40 then '40s'
	when "Age" <=50 then '50'
	else '60'
end as age_group,count(*) as total
from cinema_hall_ticket_sales chts 
group by 1
order by 2 desc;

--Favorit movie for each age group--
WITH GenreRank AS (
  SELECT 
    CASE 
      WHEN "Age" <= 10 THEN '10s'
      WHEN "Age" <= 20 THEN '20s'
      WHEN "Age" <= 30 THEN '30s'
      WHEN "Age" <= 40 THEN '40s'
      WHEN "Age" <= 50 THEN '50s'
      ELSE '60s'
    END AS age_group,
    "Movie_Genre",
    COUNT("Movie_Genre") AS total,
    RANK() OVER (PARTITION BY 
      CASE 
        WHEN "Age" <= 10 THEN '10s'
        WHEN "Age" <= 20 THEN '20s'
        WHEN "Age" <= 30 THEN '30s'
        WHEN "Age" <= 40 THEN '40s'
        WHEN "Age" <= 50 THEN '50s'
        ELSE '60s'
      END
      ORDER BY COUNT("Movie_Genre") DESC
    ) AS rnk
  FROM cinema_hall_ticket_sales
  GROUP BY age_group, "Movie_Genre"
)
SELECT age_group, "Movie_Genre", total
FROM GenreRank
WHERE rnk = 1
ORDER BY total desc;

-- total seat type
select "Seat_Type" ,count(*) as total from cinema_hall_ticket_sales chts 
group by 1
order by 2 desc;

-- total movie by seat type
select "Movie_Genre","Seat_Type", count("Seat_Type") as total,
rank() over(partition by "Movie_Genre" order by count("Seat_Type")desc) as rank 
from cinema_hall_ticket_sales chts
group by 1,2;

-- Total number of person--
select "Number_of_Person",count(*) as total
from cinema_hall_ticket_sales chts 
group by 1
order by 2 desc;

-- Movie genre for each number of person--
select "Movie_Genre","Number_of_Person", count("Number_of_Person") as total,
rank() over(partition by "Movie_Genre" order by count("Number_of_Person") desc) as rank
from cinema_hall_ticket_sales chts 
group by 1,2;

--total purchase again--
select "Purchase_Again",count(*) as total
from cinema_hall_ticket_sales chts 
group by 1
order by 2 desc;

-- movie genre by repurchase--
select "Movie_Genre","Purchase_Again" , count("Purchase_Again") as total,
rank() over(partition by "Movie_Genre" order by count("Purchase_Again") desc) as rank
from cinema_hall_ticket_sales chts 
group by 1,2;

-- Seat type genre by repurchase--
select "Seat_Type" ,"Purchase_Again" , count("Purchase_Again") as total,
rank() over(partition by "Seat_Type" order by count("Purchase_Again") desc) as rank
from cinema_hall_ticket_sales chts 
group by 1,2;

-- number of person by repurchase--
select "Number_of_Person" ,"Purchase_Again" , count("Purchase_Again") as total,
rank() over(partition by "Number_of_Person" order by count("Purchase_Again") desc) as rank
from cinema_hall_ticket_sales chts 
group by 1,2;
