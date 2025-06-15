# 🛒 Blinkit Grocery Sales Analysis (SQL + Tableau)

This project presents a comprehensive analysis of Blinkit's grocery sales data using **MySQL** for backend querying and **Tableau** for data visualization. It explores key sales metrics, customer behavior, outlet performance, and category trends to provide meaningful business insights.

---

## 📌 Objective

To analyze grocery transaction data from Blinkit (formerly Grofers) and uncover patterns in:

- Total sales and revenue distribution
- Performance of different outlet types and item categories
- Customer ratings and preferences
- Item visibility and promotion effectiveness

---

## 🧰 Tools & Technologies

| Tool      | Purpose                       |
|-----------|-------------------------------|
| MySQL     | Data cleaning and analysis     |
| Tableau   | Data visualization & dashboards |


---

## 📊 Key KPIs & Metrics

- 💰 **Total Sales**  
- 💵 **Average Sales per Transaction**  
- ⭐ **Average Customer Rating**  
- 📦 **Total Number of Items Sold**  
- 👀 **Average Item Visibility**  

---

## 🧹 Data Cleaning (SQL)

Standardized inconsistent fields such as `Item Fat Content` using SQL updates:
```sql
UPDATE blinkit_data
SET `Item Fat Content` = CASE
    WHEN `Item Fat Content` IN ('LF', 'low fat') THEN 'Low Fat'
    WHEN `Item Fat Content` = 'reg' THEN 'Regular'
    ELSE `Item Fat Content`
END;
```

---

## 📷 Dashboard Preview


![Tableau Public - blinkitsalesanalysis 15-06-2025 00_29_17](https://github.com/user-attachments/assets/622e14d8-b118-4783-9851-632e7beac280)
