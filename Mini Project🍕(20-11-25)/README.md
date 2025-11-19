## 🧀The Great Pizza Analytics Challenge

*A SQL Mini-Project Using the IDC Pizza Database*

Welcome to **The Great Pizza Analytics Challenge!**
This mini-project simulates a real-world scenario where you work as the **Data Analyst for IDC Pizza**, analyzing sales data to uncover insights, trends, and opportunities.

The project is divided into **3 phases + 8 additional insights**, totaling **25 SQL questions**, each solved with a query and output.

## 📂 Project Overview

This project focuses on hands-on SQL practice, covering:

- Database creation & schema design
- Filtering & conditional logic
- Joins (inner, left, right, full, self)
- Grouping & aggregation
- Data cleaning & NULL handling
- Basic sales analytics
- Insight generation

## 🗃️ Dataset Structure

The project uses four relational tables:

**1. pizza_types**
- Contains pizza information:
- pizza_type_id, name, category, ingredients

**2. pizzas**
- Size and price details:
- pizza_id, pizza_type_id, size, price

**3. orders**
- Order-level metadata:
- order_id, date, time

**4. order_details**
- Line-item details for orders:
- order_details_id, order_id, pizza_id, quantity

## 🎯 PHASE 1: Foundation & Inspection (4 Questions)

### Focus: Basic exploration, checking data structure, NULL handling, and first-level analysis.

 1. Install and set up the IDC_Pizza database
 2. List all unique pizza categories (DISTINCT)
 3. Display pizza_type_id, name, and ingredient list, replace NULLs with "Missing Data"
 4. Find pizzas missing a price (IS NULL)

## 🔍 PHASE 2: Filtering & Exploration (6 Questions)

### Focus: WHERE, BETWEEN, LIKE, IN, time filters, and sorting.

 5. Fetch orders placed on '2015-01-01'
 6. List pizzas ordered by price (descending)
 7. List pizzas in sizes 'L' or 'XL'
 8. Find pizzas priced between $15.00–$17.00
 9. Find pizzas with "Chicken" in the name
 10. Orders placed on '2015-02-15' or after 8 PM

## 📊 PHASE 3: Sales Performance & Business Insights (7 Questions)

### Focus: Aggregations, grouping, joins, and intermediate analysis.

 11. Total quantity of pizzas sold (SUM)
 12. Calculate the average pizza price (AVG)
 13. Compute order-wise revenue using joins
 14. Total quantity sold per pizza category
 15. Categories with more than 5,000 pizzas sold (HAVING)
 16. Pizzas never ordered (LEFT/RIGHT JOIN)
 17. Price differences between pizza sizes (SELF JOIN)

## ➕ ADDITIONAL INSIGHTS (8 Bonus Questions)

 18. Total revenue generated
 19. Top-selling pizza
 20. Highest revenue-generating pizza category
 21. Most frequently ordered size
 22. Peak ordering hour
 23. Monthly sales trend
 24. Most common ingredients used across pizzas
 25. Highest revenue day in the dataset

## ⭐ Key Takeaways (Collective Insights)

- More than 49k pizzas were sold across all orders
- Classic and Chicken pizzas dominate in both sales and revenue
- Large (L) and Extra-Large (XL) sizes are most preferred
- Order volume peaks between 6 PM – 9 PM
- Weekends outperform weekdays, especially Saturdays
- Several pizzas had missing or NULL data, which required cleaning
- Some pizzas were never ordered, indicating low visibility or demand
- Price scaling from S → XL is consistent, supporting price optimization
- Ingredient analysis shows cheese-based and chicken-based pizzas are most popular

## 🛠️ Tech Stack

- SQL (MySQL)
- DB Schema Design
- Data Cleaning Techniques
- Aggregation & Joins
- Query Optimization Basics
