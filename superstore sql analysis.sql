#What is the total sales and profit for each category and sub-category?
SELECT 
    category,
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM
    superstore
GROUP BY Category , Sub_Category
ORDER BY total_sales , total_profit DESC;

#Which products contribute the most to overall sales and profit?
select product_id,
 Product_name , 
sum(sales) as total_sales ,
sum(profit) as total_profit,
sum(sales) * 100 / (select sum(sales) from superstore) as sales_contibution,
sum(profit) * 100 / (select sum(profit) from superstore) as profit_contibution
from superstore
group by Product_Name,Product_ID
order by total_Sales desc;

#Identify the top 10 most profitable products and bottom 10 least profitable products.
SELECT product_name, sum(profit) as total_profit
from superstore
group by Product_Name
order by total_profit desc
limit 10 ;

SELECT product_name, sum(profit) as total_profit
from superstore
group by Product_Name
order by total_profit asc
limit 10 ;

#What is the profit margin for each product category? 
select category , sum(Sales) as total_sales, sum(profit) as total_profit,
round(sum(profit)/sum(sales) * 100,2) as profit_margin
from superstore 
group by category
order by profit_margin desc;

#Which regions generate the highest sales and profit?
select region, sum(sales) as total_sales, sum(profit) as total_profit
from superstore
group by region
order by total_sales desc;

#How many unique customers are there?
select count(distinct customer_name) as unique_customers
 from superstore ;
 
 #Who are the top 10 customers based on total purchase value?
 select customer_name , sum(sales) as purchase_value
 from superstore
 group by Customer_Name
 order by purchase_value desc
 limit 10;
 
 #What is the average order value? (Total Sales / Number of Orders)
 select avg(sales/quantity) as avg_order
 from superstore;
 
 #What is the average delivery time per shipping mode?
select ship_mode, avg(datediff(ship_date,order_date)) as avg_delivery_time
from superstore
 group by ship_mode
 order by avg_delivery_time asc ;
 
 #Which shipping mode is most commonly used?
 select ship_mode , count(ship_mode) as number_of_time_used
 from superstore
 group by ship_mode
 order by number_of_time_used desc;
 
 #Which state or city has the longest average delivery time?
 select state , city , avg(datediff(ship_date,order_date)) as average_delivery_days
 from superstore 
 group by state,city
 order by average_delivery_days desc
 limit 10;

#What is the average discount given per product category?
select category , round(avg(discount)*100,2) as avg_discount
from superstore
group by category
order by avg_discount desc;

#How does discount percentage affect profit?
SELECT 
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount BETWEEN 0.01 AND 0.10 THEN 'Low Discount (1-10%)'
        WHEN discount BETWEEN 0.11 AND 0.25 THEN 'Medium Discount (11-25%)'
        WHEN discount > 0.25 THEN 'High Discount (>25%)'
    END AS discount_category, 
    SUM(sales) AS total_sales, 
    SUM(profit) AS total_profit, 
    ROUND(AVG(profit / sales) * 100, 2) AS avg_profit_margin
FROM superstore
GROUP BY discount_category
ORDER BY avg_profit_margin DESC;

#How do sales and profit vary by year and month?
SELECT 
    YEAR(order_date) AS year, 
    MONTH(order_date) AS month, 
    SUM(sales) AS total_sales, 
    SUM(profit) AS total_profit, 
    ROUND(AVG(profit / sales) * 100, 2) AS avg_profit_margin_pct
FROM superstore
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;
    
#Which months have the highest sales?
select 
month(order_date) as month,
sum(sales) as total_sales
from superstore
group by month(order_date)
order by total_sales desc;

#Which months have the lowest sales?
select 
month(order_date) as month,
sum(sales) as total_sales
from superstore
group by month(order_date)
order by total_sales asc;