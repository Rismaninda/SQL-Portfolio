-- show total order for each customer
select c.customer_id, sum(o.amount)
from customers c join orders o on
c.customer_id=o.customer_id
group by c.customer_id
order by 2 desc;

--shipping status for each customer name
select c.customer_id, c.first_name, s.status
from customers c join shippings s on
c.customer_id=s.customer
order by 3 asc;

--total amount each country
select country,sum(amount) as total from
customers c join orders o on
c.customer_id=o.customer_id
group by 1;

--show item order that have "Pending" status
select o.item, s.status 
from orders o join shippings s on
o.customer_id=s.customer
where s.status="Pending";

-- show customer with more than 1 order
select o.customer_id, c.first_name, c.last_name
from customers c join orders o on
c.customer_id=o.customer_id
group by 1
having count(*)>1;

-- customer with highest order
select c.first_name, c.last_name, sum(o.amount) as total
from customers c join orders o on
c.customer_id=o.customer_id
group by 1,2
order by 3 desc
limit 1;

-- customer with no order
SELECT c.first_name, c.last_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- show customer with highest shipping_id
select c.customer_id, s.shipping_id, c.first_name,c.last_name, s.status 
from customers c join shippings s on
c.customer_id=s.customer
where s.shipping_id = (
  select max(shipping_id) from shippings
where c.customer_id=s.customer
)
limit 1;

select c.customer_id, s.shipping_id, c.first_name,c.last_name, s.status 
from customers c join shippings s on
c.customer_id=s.customer
group by 2
order by 2 desc
limit 1;

-- show status order and order for customer who have amount order > 350 and "delivered"
select c.customer_id, c.first_name, o.item, o.amount,s.status
from customers c join orders o on
c.customer_id=o.customer_id 
join shippings s on
o.customer_id=s.customer
where o.amount>350 and
s.status="Delivered"
order by 4 desc;


--show the precentage for each status
select status, count(*) *100 / (select count(*) from shippings) as precentage
from shippings
group by status;




