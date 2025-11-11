# ☕ Coffee Shop Sales Analysis Dashboard  

## 📊 Project Overview  
This project analyzes sales data from a coffee shop chain to uncover trends in **total sales, orders, and quantity sold**.  
Using **SQL** for data processing and **Power BI** for visualization, the dashboard provides actionable business insights such as month-on-month growth, daily sales behavior, and top-performing products and locations.

---

## 🎯 Objective  
To transform raw sales data into meaningful insights that help the business:  
- Track performance across stores and product categories.  
- Identify sales trends and seasonal patterns.  
- Compare weekday vs. weekend and hourly performance.  
- Support strategic, data-driven decision-making.  

---

## 🧠 Key Insights Delivered  
- **KPI Tracking:** Total Sales, Total Orders, and Quantity Sold with MoM comparison.  
- **Calendar Heatmap:** Day-wise visualization of sales intensity.  
- **Weekday vs. Weekend Sales:** Behavioral comparison of customer activity.  
- **Store Location Performance:** MoM trends and top/low-performing locations.  
- **Daily Sales Analysis:** Line chart with average line to highlight exceptional days.  
- **Product Category & Top 10 Products:** Identified revenue-driving categories and items.  
- **Hourly Heatmap:** Shows peak hours and low-traffic periods.  

---

## ⚙️ Tools & Technologies  
| Tool | Purpose |
|------|----------|
| **MySQL** | Data cleaning, transformation, and KPI computation |
| **Power BI** | Interactive dashboards and data visualization |
| **Excel/CSV** | Source data preparation |
| **SQL Functions Used** | `LAG()`, `CASE`, `ROUND()`, `GROUP BY`, `MONTH()`, `DAYOFWEEK()` |

---

## 🧱 Data Processing Workflow (MySQL)  
1. Prepare and clean the raw data file.  
2. Create and configure the database.  
3. Convert `transaction_date` and `transaction_time` to valid SQL types.  
4. Compute monthly KPIs: Sales, Orders, Quantity.  
5. Use **window functions** for Month-on-Month comparison.  
6. Export cleaned and aggregated data for Power BI.  
7. Create dashboards and visualizations.  

---

## 📈 Power BI Dashboard Features  
- **Calendar Heatmap:** Daily sales intensity with tooltips for sales, orders, and quantity.  
- **Store Comparison View:** Highlights MoM changes for each store.  
- **Top 10 Products Chart:** Ranks highest-selling items.  
- **Weekday vs Weekend Report:** Analyzes customer buying patterns.  
- **Sales by Hour Heatmap:** Reveals high-traffic hours for optimization.  

---

## 🧮 Example SQL Queries  

```sql
-- Total Sales by Month
SELECT 
  MONTH(transaction_date) AS Month,
  ROUND(SUM(unit_price * transaction_qty), 1) AS Total_Sales
FROM coffee_shop_sales
GROUP BY Month;

-- Month-on-Month Growth
SELECT 
  MONTH(transaction_date) AS Month,
  ROUND(SUM(unit_price * transaction_qty), 1) AS Total_Sales,
  (SUM(unit_price * transaction_qty) - 
   LAG(SUM(unit_price * transaction_qty), 1) OVER(ORDER BY MONTH(transaction_date))) /
   LAG(SUM(unit_price * transaction_qty), 1) OVER(ORDER BY MONTH(transaction_date)) * 100 
   AS MoM_Growth_Percentage
FROM coffee_shop_sales
GROUP BY Month;
```

## 📷 Dashboard Preview


