CREATE database	coffee_shop_sales_db

SELECT * from coffee_shop_sales

DESCRIBE coffee_shop_sales

SET SQL_SAFE_UPDATES = 0 

UPDATE coffee_shop_sales
SET transaction_date = STR_TO_DATE(transaction_date,'%d/%m/%Y')

ALTER TABLE coffee_shop_sales
MODIFY COLUMN transaction_date DATE;


UPDATE coffee_shop_sales
SET transaction_time = STR_TO_DATE(transaction_time,'%H:%i:%s')

ALTER TABLE coffee_shop_sales
MODIFY COLUMN transaction_time TIME;

-- Total sales for respective month
SELECT MONTH(transaction_date) as Month, round(SUM(unit_price * transaction_qty),1) as Total_Sales 
from coffee_shop_sales
group by Month

-- Month on Month increase or decrease in sales
SELECT 
	MONTH(transaction_date) as Month, 
	round(SUM(unit_price * transaction_qty),1) as Total_Sales,
    (SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty),1) OVER(order by MONTH(transaction_date)))/
    LAG(SUM(unit_price * transaction_qty),1) OVER(order by MONTH(transaction_date)) *100 as mom_inc_percentage
from coffee_shop_sales
group by Month

-- Orders for each month
SELECT Month(transaction_date) as Month, Count(transaction_id) as Orders
FROM coffee_shop_sales
group by Month

-- Month on Month increase or decrease in Orders
SELECT 
	Month(transaction_date) as Month, 
    Count(transaction_qty) as Orders,
    Count(transaction_qty) - Lag(Count(transaction_qty),1) Over() As MOM_inc_orders
FROM coffee_shop_sales
group by Month

-- Quantity for each month
SELECT Month(transaction_date) as Month, SUM(transaction_qty) as Quantity
FROM coffee_shop_sales
group by Month

-- Month on Month increase or decrease in Quantity
SELECT 
	Month(transaction_date) as Month, 
    SUM(transaction_qty) as Quantity,
    SUM(transaction_qty) - Lag(SUM(transaction_qty),1) Over() As MOM_inc_Quantity
FROM coffee_shop_sales
group by Month

-- CALENDAR TABLE – DAILY SALES, QUANTITY and TOTAL ORDERS
SELECT 
	Concat(Round(SUM(unit_price * transaction_qty)/1000,1),"k") as Total_sales,
    Concat(Round(SUM(transaction_qty)/1000,1),"k") as Total_Quantity,
    Concat(Round(Count(transaction_id)/1000,1),"k") as Total_orders
from coffee_shop_sales    
WHERE transaction_date = "2023-03-27"

-- Sales Analysis by Weekdays and Weekends
Select 
	Month(transaction_date) as Month,
	CASE WHEN DAYOFWEEK(transaction_date) in (1,7) THEN "Weekends"
    ELSE "Weekdays"
    END as Day_type,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,1),"k") as Total_sales
FROM coffee_shop_sales    
GROUP BY Day_type, Month   

-- Sales Analysis by Store Location
Select 
	store_location,
    Concat(Round(Sum(unit_price * transaction_qty)/1000,1),"k")
 from coffee_shop_sales  
 Group by store_location

-- Month on Month Sales Analysis by Store Location
Select 
	Month(transaction_date) as Month,
	store_location,
    Concat(Round(Sum(unit_price * transaction_qty)/1000,1),"k")
from coffee_shop_sales  
Where Month(transaction_date) = 5 -- May
Group by store_location

-- Month on Month Average Sales
Select 
	Month(t_date) as Month,
	Concat(Round(Avg(total_sales)/1000,1),"k") as Avg_Sales
 From
	(
    Select 
		transaction_date as t_date,
        SUM(unit_price * transaction_qty) as total_sales
    FROM coffee_shop_sales
    Group by t_date
    ) as Int_table
Group by Month(t_date)
 
 -- Daily Sales
Select 
		DAY(transaction_date) as Day_of_month,
        SUM(unit_price * transaction_qty) as total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
Group by Day_of_month

-- Sales Status
SELECT 
	Day_of_month,
    Avg_sales,
    CASE 
    WHEN total_sales > Avg_sales THEN "Above Average"
    WHEN total_sales < Avg_sales THEN "Below Average"
    ELSE "Equal to Average"
    END AS Sales_Status,
    total_sales
FROM
	(
    Select 
		DAY(transaction_date) as Day_of_month,
        Sum(unit_price * transaction_qty) as total_sales,
		Avg(SUM(unit_price * transaction_qty)) OVER() AS Avg_sales
        FROM coffee_shop_sales
        WHERE Month(transaction_date) = 5 -- May
        GROUP BY Day_of_month
    ) AS Sales_data
    ORDER by Day_of_month

-- Sales by Product Category
SELECT 
	product_category,
    Concat(Round(Sum(unit_price * transaction_qty)/1000,1),"k") as Total_sales
from coffee_shop_sales  
WHERE month(transaction_date) = 5 -- May
group by product_category  
order by Sum(unit_price * transaction_qty) DESC   
 
-- Sales by Product Type
SELECT 
	product_type,
    Concat(Round(Sum(unit_price * transaction_qty)/1000,1),"k") as Total_sales
from coffee_shop_sales  
WHERE month(transaction_date) = 5 -- May
group by product_type  
order by Sum(unit_price * transaction_qty) DESC      
LIMIT 10 

-- Sales Analysis by day and hours
SELECT 
    Sum(unit_price * transaction_qty) as Total_sales,
    Sum(transaction_qty) as Total_qty_sold,
    Count(*) as Total_orders
from coffee_shop_sales  
Where Month(transaction_date) = 5 -- May
and DAYOFWEEK(transaction_date) = 2 -- Monday
and HOUR(transaction_time) = 8 -- Hour 8 

-- Sales analysis by Days
SELECT 
	CASE 
    WHEN Dayofweek(transaction_date) = 2 THEN "Monday"
    WHEN Dayofweek(transaction_date) = 3 THEN "Tuesday"
    WHEN Dayofweek(transaction_date) = 4 THEN "Wednesday"
    WHEN Dayofweek(transaction_date) = 5 THEN "Thursday"
    WHEN Dayofweek(transaction_date) = 6 THEN "Friday"
    WHEN Dayofweek(transaction_date) = 7 THEN "Saturday"
    Else "Sunday"
    END as Day_of_week,
    Round(Sum(unit_price * transaction_qty),1) as Total_sales
FROM coffee_shop_sales
WHERE Month(transaction_date) = 5    
Group by Day_of_week
    




