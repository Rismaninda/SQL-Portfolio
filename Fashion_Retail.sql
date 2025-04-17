--Preview Data
select * from shopping_trends 
limit 10;

--Loyal Customer by total purchase--
select "Customer ID", sum("Purchase Amount (USD)") as total, count(*) as total_purchase
from shopping_trends st 
group by "Customer ID" 
order by 2 desc;

--Total customer by Gender
select 
(select count(*) from shopping_trends st where "Gender" ='Male') as Male,
(select count(*) from shopping_trends where "Gender"='Female') as Female;

-- Total Amount by Gender
select "Gender" ,
sum("Purchase Amount (USD)") as total_amount from shopping_trends st 
group by "Gender" 
order by 2 desc ;

-- Total customer by Category
select "Category" ,
count(*) as Total from shopping_trends st 
group by "Category" ;

-- Total Amount by Category
select "Category" ,
sum("Purchase Amount (USD)") as total_amount from shopping_trends st 
group by "Category" 
order by 2 desc ;

-- Total Customer by Season
select "Season",
count(*) as Total from shopping_trends st 
group by "Season" 
order by Total desc;

-- Total Amount by Season
select "Season" ,
sum("Purchase Amount (USD)") as total_amount from shopping_trends st 
group by "Season" 
order by 2 desc ;

--Most buy in Fall Season--
select "Category", sum("Purchase Amount (USD)") as total
from shopping_trends st 
where "Season" ='Fall'
group by 1
order by 2 desc;

-- Amount Customer by Frequency of Purchases
select "Frequency of Purchases" ,
sum("Purchase Amount (USD)") as total_amount, 
count(*) as Total from shopping_trends st 
group by "Frequency of Purchases" 
order by 2 desc;

-- Customer who buy Pink Clothing with L size
select * from shopping_trends st 
where "Category" ='Clothing'
and "Size" ='L'
and "Color" ='Pink';

-- Age of Customer who buy Outerwear weekly
select "Age",count(*) as total, "Category","Frequency of Purchases" from shopping_trends st 
where "Category" ='Outerwear'
and "Frequency of Purchases" ='Weekly'
group by "Age","Category" ,"Frequency of Purchases" 
order by 2 desc;


-- TOP 5 Favorite Color by Season (Top 4 per Season) --
WITH ranked_color AS (
  SELECT 
    "Color", 
    "Season", 
    COUNT(*) AS total,
    RANK() OVER(PARTITION BY "Season" ORDER BY COUNT(*) DESC) AS fav
  FROM shopping_trends st 
  GROUP BY "Color", "Season"
)
SELECT * 
FROM ranked_color
WHERE fav <= 5;

-- TOP 5 Favorite Item by Season (Top 4 per Season) --
with item as
(select "Item Purchased","Season",count(*) as total,
rank() over(partition by "Season" order by count(*) desc) as fav
from shopping_trends st 
group by "Item Purchased" ,"Season" )
select * from item
where fav<=5;

-- TOP 5 Favorite Color by gender (Top 4 per Season) --
WITH ranked_color AS (
  SELECT 
    "Color", "Gender" , 
    COUNT(*) AS total,
    RANK() OVER(PARTITION BY "Gender"  ORDER BY COUNT(*) DESC) AS fav
  FROM shopping_trends st 
  GROUP BY "Color", "Gender" 
)
SELECT * 
FROM ranked_color
where fav<4;

-- TOP 5 Favorite Item by gender (Top 4 per Season) --
with item as
(select "Item Purchased","Gender",count(*) as total,
rank() over(partition by "Gender" order by count(*) desc) as fav
from shopping_trends st 
group by "Item Purchased" ,"Gender" )
select * from item
where fav<=5;

--Size by gender--
with size as
(select st."Size" ,st."Gender" ,count(*) as total,
rank() over(partition by st."Gender"  order by count(*) desc) as fav
from shopping_trends st 
group by st."Size" ,st."Gender" )
select * from size
where fav=1;

--Item per size--
with item as 
(select st."Size" ,st."Item Purchased" ,COUNT(*) as total,
rank() over(partition by st."Item Purchased" order by COUNT(*) desc) as fav
from shopping_trends st 
group by st."Size", st."Item Purchased" )
select * from item 
where fav<=3;
