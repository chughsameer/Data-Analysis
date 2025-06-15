--  Retrieve all rows and columns from the blinkit_data table
SELECT * FROM blinkit_data

--  Count the total number of records (rows) in the table
SELECT COUNT(*) from blinkit_data

--  Get all unique values from the 'Item Fat Content' column
SELECT distinct(`Item Fat Content`) from blinkit_data

-- 🔓 Disable safe update mode to allow updating records
SET SQL_SAFE_UPDATES = 0;

-- 🧹 Standardize inconsistent values in the 'Item Fat Content' column
UPDATE blinkit_data
SET `Item Fat Content` = CASE
	-- Convert shorthand and lowercase values to a consistent format
	WHEN `Item Fat Content` IN ('LF','low fat') THEN 'Low Fat'
	WHEN `Item Fat Content` = 'reg' THEN 'Regular'
	ELSE `Item Fat Content`
	END

-- 💰 Calculate the total revenue generated from all sales
SELECT ROUND(SUM(`Total Sales`), 2) AS Total_Revenue FROM blinkit_data;

-- 💵 Calculate the average sales per transaction/item
SELECT ROUND(AVG(`Total Sales`), 2) AS Avg_Sales FROM blinkit_data;

-- 📦 Count the total number of items sold (records)
SELECT COUNT(*) AS Number_of_Items FROM blinkit_data;

-- ⭐ Calculate the average customer rating
SELECT ROUND(AVG(Rating), 2) AS Avg_Rating FROM blinkit_data;

-- 📊 Sales analysis by 'Item Fat Content' category
SELECT `Item Fat Content`,
       ROUND(SUM(`Total Sales`), 2) AS Total_Sales,
       ROUND(AVG(`Total Sales`), 2) AS Avg_Sales,
       COUNT(*) AS Number_of_Items,
       ROUND(AVG(Rating), 2) AS Avg_Rating
FROM blinkit_data
GROUP BY `Item Fat Content`;

-- 🍱 Total sales by item category/type
SELECT `Item Type`,
       ROUND(SUM(`Total Sales`), 2) AS Total_Sales
FROM blinkit_data
GROUP BY `Item Type`
ORDER BY `Total Sales` DESC;

-- 🏪 Compare sales by outlet and fat content type
SELECT `Outlet Identifier`,
       ROUND(SUM(CASE WHEN `Item Fat Content`='Low Fat' THEN `Total Sales` ELSE 0 END ),2) AS Low_fat_sales,
       ROUND(SUM(CASE WHEN `Item Fat Content`='Regular' THEN `Total Sales` ELSE 0 END ),2) AS Regular_sales
FROM blinkit_data
GROUP BY `Outlet Identifier`
ORDER BY `Outlet Identifier`;

-- 🏗️ Analyze sales by the year outlets were established
SELECT `Outlet Establishment Year`,
	   ROUND(SUM(`Total Sales`),2) AS Total_sales
FROM blinkit_data
GROUP BY `Outlet Establishment Year`
ORDER BY `Outlet Establishment Year`;       

-- 📊 Distribution of total sales by outlet size in percentage
SELECT `Outlet Size`,
       ROUND(SUM(`Total Sales`) * 100 / (SELECT SUM(`Total Sales`) FROM blinkit_data), 2) AS Sales_Percentage
FROM blinkit_data
GROUP BY `Outlet Size`
ORDER BY `Outlet Size`;

-- 🌍 Total sales contribution by location type (e.g., Tier 1, Tier 2)
SELECT `Outlet Location Type`,
       ROUND(SUM(`Total Sales`), 2) AS Total_Sales
FROM blinkit_data
GROUP BY `Outlet Location Type`;

-- 🏬 Summary of KPIs by outlet type
SELECT `Outlet Type`,
       ROUND(SUM(`Total Sales`), 2) AS Total_Sales,
       ROUND(AVG(`Total Sales`), 2) AS Avg_Sales,
       COUNT(*) AS Number_of_Items,
       ROUND(AVG(Rating), 2) AS Avg_Rating
FROM blinkit_data
GROUP BY `Outlet Type`
ORDER BY `Outlet Type`;