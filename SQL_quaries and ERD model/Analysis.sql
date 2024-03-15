use sup_market;

-- check sales table
select * from sales;

-- Feature engineering 

-- 1. Add "name_of_day" column 
Alter table sales Add column name_of_day varchar(10);

update sales 
set name_of_day = dayname(date);

-- 2. Add "name_of_month" column
Alter table sales Add column name_of_month varchar(10);

update sales
set name_of_month = monthname(date);

-- EDA(exploratory data analysis)

-- How many unique cities are there?
select distinct city from sales;

-- In which city is each branch?
select distinct city, branch from sales
order by branch; 

-- How many unique product lines are there?
select distinct product_line from sales;

-- What is the most selling prodcut line?
select sum(quantity) as Qty, product_line from sales 
group by product_line
order by Qty DESC;

-- What is the total revenue by month
select name_of_month As month, round(sum(total), 2) As total_revenue
from sales 
group by name_of_month
order by total_revenue;

-- Which cities gain the largest revenue?
select branch, city, round(sum(total), 2) As total_revenue
from sales 
group by city, branch
order by total_revenue;

-- What product_line brought the largest revenue?
select product_line, Round(sum(total),2) as total_revenue
from sales 
group by product_line 
order by total_revenue DESC;

-- What product line had the largst VAT?
select product_line, Round(avg(tax_pct),2) as AVG_tax
from sales 
group by product_line
order by AVG_tax;

-- Extract each product line then add a column to the prodcut lines displaying "Good or Bad".
-- If it is greater than average sales "Good" other wise "Bad" sales condition.
-- Calculate average quantity first
select avg(quantity) as AVG_qnty from sales;

select product_line,
case 
    when AVG(quantity) > 5.5 then "Good"
else "Bad"
END AS sales_condition
from sales 
group by product_line;

-- Which branch sold more products than average product sold?
select branch, sum(quantity) As Qty from sales
group by branch 
having sum(quantity) > (select AVG(quantity) from sales);

-- What is the most common product line by gender?
select gender, product_line, count(gender) AS num_gender
from sales 
group by gender, product_line
order by num_gender DESC;

-- What is the average rating of each product line?
select round(AVG(rating), 1) as AVG_rating, product_line 
from sales 
group by product_line
order by AVG_rating DESC;

-- Number of sales made on each day?
select name_of_day, count(*) as total_sales
from sales
group by name_of_day 
order by total_sales desc;

-- Which customer type brings the most revenue?
select customer_type, Round(sum(total),2) as total_revenue
from sales 
group by customer_type
order by total_revenue;

-- How many unique payments are there?
select distinct payment from sales;

-- Which customer type buys the most?
select customer_type, count(*) from sales 
group by customer_type;

-- What is the gender of most of the customers?
select gender, count(*) as Gender_count from sales 
group by gender
order by Gender_count DESC;

-- Which day of the week had the best average ratings?
select name_of_day, Round(AVG(rating),1) AS AVG_rating from sales
group by name_of_day 
order by AVG_rating DESC;




