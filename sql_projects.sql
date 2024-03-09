create database if not exists salesdatawalmart;
drop table sales;
use salesdatawalmart;
create table if not exists sales(
invoice_id varchar(50) not null primary key,
branch varchar(5) not null,
city varchar(30) not null,
customer_type varchar(30) not null,
gender varchar(10) not null,
product_line varchar(100) not null,
unit_price decimal(10,2) not null,
quantity int not null,
vat float not null,
total decimal(12,4) not null,
date datetime not null,
time time not null,
payment_method varchar(15) not null, 
cogs decimal(10,2) not null,
gross_margin_pct float,
gross_income decimal(12,4) not null,
rating float
);
select time,
(case
when 'time' between "00:00:00" and  "12:00:00"  then "morning"
when 'time' between "12:00:00" and  "16:00:00" then "afternoon"
else "evening"
end) as time_of_day
from sales;

alter table sales add column time_of_day varchar(20);


update sales
set time_of_day = (case
when time between "00:00:00" and  "12:00:00"  then "morning"
when time between "12:00:00" and  "16:00:00" then "afternoon"
else "evening"
end);
select * from sales;
select date, dayname(date)
from sales;

alter table sales add column day_name varchar(10);
select * from sales;
update sales 
set day_name=dayname(date);

select date, monthname(date)
from sales;

alter table sales add column monthname varchar(10);

update sales
set monthname = monthname(date);

select distinct city from sales;
select distinct city,branch from sales;

select distinct branch from sales; 

select count( distinct product_line) from sales;

select payment_method, count(payment_method) as cnt
from sales
group by payment_method
order by cnt desc;

select product_line, count(product_line) as cnt
from sales
group by product_line
order by cnt desc;

select monthname as month, sum(total) as total_revenue
from sales
group by monthname
order by sum(total) desc;

select monthname, sum(cogs) as cogs
from sales
group by monthname
order by sum(cogs) desc;

select 
product_line,
sum(total) as total_revenue
from sales
group by product_line
order by total_revenue desc;

select branch, city, sum(total) as total_revenue
from sales
group by city, branch
order by total_revenue desc;

select product_line, avg(vat) as avg_tax
from sales
group by product_line
order by avg_tax desc;

WITH avg_sales_per_product_line AS (
    SELECT 
        product_line,
        AVG(total) AS avg_total
    FROM 
        sales
    GROUP BY 
        product_line
)
SELECT 
    sales.*,
    CASE 
        WHEN sales.total > avg_sales.avg_total THEN 'Good'
        ELSE 'Bad'
    END AS label
FROM 
    sales
JOIN 
    avg_sales_per_product_line avg_sales ON sales.product_line = avg_sales.product_line;
    
select avg(quantity) from sales;
select branch,sum(quantity) as qty
from sales 
group by branch
having sum(quantity) > (select avg(quantity) from sales);

select gender,product_line,count(gender) as total_cnt
from sales 
group by gender, product_line
order by total_cnt desc;

select avg(rating) as avg_rating,
product_line
from sales
group by product_line
order by avg_rating desc;

select time_of_day, count(total) as total_sales
from sales
where day_name = "sunday"
group by time_of_day;

select   customer_type ,sum(total) as total_rev
from sales 
group by customer_type
order by sum(total) desc;

select city,avg(vat) as vat
from sales
group by city
order by avg(vat) desc;

select customer_type ,avg(vat) as vat
from sales
group by customer_type
order by avg(vat) desc;

select distinct customer_type from sales;

select customer_type, count(*) as cnt
from sales
group by customer_type
order by cnt desc;

select gender , count(*) as gender_cnt
from sales
group by gender
order by gender_cnt;

select time_of_day, avg(rating)
from sales
group by time_of_day
order by avg(rating) desc;

select time_of_day, avg(rating)
from sales
where branch = "c"
group by time_of_day
order by avg(rating) desc;

select day_name, avg(rating) as avg_rating
from sales
group by day_name
order by avg_rating desc;

select day_name, avg(rating) as avg_rating
from sales
where branch = "a"
group by day_name
order by avg_rating desc;