create database pizzadata;
use pizzadata;

ALTER TABLE pizza_sales_excel_file
MODIFY COLUMN order_date date;

UPDATE pizza_sales_excel_file
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');


-- show some data 
select * from pizza_sales_excel_file limit 100;

-- find total revenue
select round(sum(total_price),2) as total_revenue from pizza_sales_excel_file;

-- find average order value
select round(sum(total_price)/count(distinct order_id),2) as avg_value from pizza_sales_excel_file;

-- total number of pizza sold
select sum(quantity) as total_number from pizza_sales_excel_file;

-- total number of order placed
select count(distinct order_id) as number_of_order from pizza_sales_excel_file;

-- average number of pizza sold per order
select sum(quantity)/count(distinct order_id) as avg_number_of_pizza from pizza_sales_excel_file;

-- find number of order per day
SELECT DAYNAME(order_date) AS day_name, count(distinct order_id) as num from pizza_sales_excel_file group by day_name;

-- find number of order as per months
select MONTHNAME(order_date) AS month_name, count(distinct order_id) as num from pizza_sales_excel_file group by month_name;

-- percentage of sales by pizza catagory
with cte as(
select pizza_category, round(sum(total_price),2) as s from pizza_sales_excel_file group by pizza_category)

select pizza_category, s, round((s/ sum(s) over())*100,2) as percentage_sale from cte; 

-- percentage of sales by pizza size
with cte as(select pizza_size, round(sum(total_price),2) as total_sum from pizza_sales_excel_file group by pizza_size)

select pizza_size, total_sum, round((total_sum/ sum(total_sum) over())*100,2) as percentage_sale from cte;

-- total pizza sold by pizza catagory
select pizza_category, sum(quantity) as num_of_pizza from pizza_sales_excel_file group by pizza_category;

-- top 5 best seller by revenue
select pizza_name, sum(total_price) as revenue from pizza_sales_excel_file group by pizza_name order by revenue desc limit 5;

-- top 5 best seller by total quantity and total orders
select pizza_name, sum(quantity) as quantity from pizza_sales_excel_file group by pizza_name order by quantity desc limit 5;

-- top 5 best seller by total orders
select pizza_name, count(distinct order_id) as total_number_of_order from pizza_sales_excel_file group by pizza_name order by total_number_of_order desc limit 5;

-- bottom 5 seller by revenue
select pizza_name, sum(total_price) as revenue from pizza_sales_excel_file group by pizza_name order by revenue limit 5;

-- bottom 5 best seller by total quantity and total orders
select pizza_name, sum(quantity) as quantity from pizza_sales_excel_file group by pizza_name order by quantity limit 5;

-- bottom 5 best seller by total orders
select pizza_name, count(distinct order_id) as total_number_of_order from pizza_sales_excel_file group by pizza_name order by total_number_of_order limit 5;
