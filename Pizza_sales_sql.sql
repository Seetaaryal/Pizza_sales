INSERT INTO [dbo].[pizza_orders]
SELECT * FROM [dbo].[pizza_sales];
Select * from [dbo].[pizza_orders];
select count(*) from [dbo].[pizza_sales];
select *
from [dbo].[pizza_orders]
where pizza_id is null
or
order_id is null
or
pizza_name_id is null
or
quantity is null
or
order_date is null
or
order_time is null
or
unit_price is null
or
total_price is null
or
pizza_size is null
or
pizza_category is null
or
pizza_ingredients is null
or
pizza_name is null

-- total revenue
select sum(total_price) As total_revenue
from [dbo].[pizza_orders];


-- Average order value/total numbers of orders
select SUM(total_price)/count(distinct order_id) As Average_Order_value
from [dbo].[pizza_orders];

-- Total Pizza Sold ---
select sum(quantity) as Total_Pizza_Sold
from [dbo].[pizza_orders];

-- Total Orders
select count(distinct order_id) as Total_orders
from [dbo].[pizza_orders];

-- Avg_Pizzas_Per_Order
SELECT 
    CAST(
        CAST(SUM(quantity) AS DECIMAL(10,2)) / 
        CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))
    AS DECIMAL(10,2)) AS average
FROM [dbo].[pizza_orders];

-- daily trend for toal orders

select datename(DW, order_date) as order_day,
		count(distinct order_id) as Total_orders
from [dbo].[pizza_orders]
Group by datename(DW, order_date);

-- Hourly rate

select datepart(Hour, order_time) as order_hours,
		count(distinct order_id) as Total_orders
from [dbo].[pizza_orders]
group by datepart(Hour, order_time)
order by datepart(Hour, order_time);

-- Percentage of sales by pizza category

SELECT 
    pizza_category,
	sum(total_price) as total_sales,
    CAST(
        SUM(total_price) * 100.0 / 
        (SELECT SUM(total_price) FROM [dbo].[pizza_orders] where Month(order_date) = 1)
        AS DECIMAL(10,2)
    ) AS Percentage_sales
FROM [dbo].[pizza_orders]
where Month(order_date) = 1
GROUP BY pizza_category;

-- Percentage of sales by pizza size
SELECT 
    pizza_size,
	sum(total_price) as total_sales,
    CAST(
        SUM(total_price) * 100.0 / 
        (SELECT SUM(total_price) FROM [dbo].[pizza_orders])
        AS DECIMAL(10,2)
    ) AS Percentage_sales
FROM [dbo].[pizza_orders]
GROUP BY pizza_size
order by Percentage_sales desc;

-- Total Pizzas Sold by Pizza category
select pizza_category,
sum(quantity) as total_Pizzas_sold
FROM [dbo].[pizza_orders]
group by pizza_category;

-- Top 5 best sellers by total pizzas sold

select top 5
	pizza_name,
sum(quantity) as total_Pizzas_sold
FROM [dbo].[pizza_orders]
group by pizza_name
order by sum(quantity) desc;

-- bottom 5 

select top 5
	pizza_name,
sum(quantity) as total_Pizzas_sold
FROM [dbo].[pizza_orders]
where month(order_date) = 8
group by pizza_name
order by sum(quantity) Asc;