## The Great Pizza Analytics Challenge

A SQL Mini-Project Using the IDC Pizza Database

Welcome to The Great Pizza Analytics Challenge!
This mini-project simulates a real-world scenario where you work as the Data Analyst for IDC Pizza, analyzing sales data to uncover insights, trends, and opportunities.

The project is divided into 3 phases + 8 additional insights, totaling 25 SQL questions, each solved with a query and output.

📂 Project Overview

This project focuses on hands-on SQL practice, covering:

Database creation & schema design

Filtering & conditional logic

Joins (inner, left, right, full, self)

Grouping & aggregation

Data cleaning & NULL handling

Basic sales analytics

Insight generation

🗃️ Dataset Structure

The project uses four relational tables:

1. pizza_types

Contains pizza information:
pizza_type_id, name, category, ingredients

2. pizzas

Size and price details:
pizza_id, pizza_type_id, size, price

3. orders

Order-level metadata:
order_id, date, time

4. order_details

Line-item details for orders:
order_details_id, order_id, pizza_id, quantity

🎯 PHASE 1: Foundation & Inspection (4 Questions)

Focus: Basic exploration, checking data structure, NULL handling, and first-level analysis.

Install and set up the IDC_Pizza database

List all unique pizza categories (DISTINCT)

Display pizza_type_id, name, and ingredient list, replace NULLs with "Missing Data"

Find pizzas missing a price (IS NULL)

🔍 PHASE 2: Filtering & Exploration (6 Questions)

Focus: WHERE, BETWEEN, LIKE, IN, time filters, and sorting.

Fetch orders placed on '2015-01-01'

List pizzas ordered by price (descending)

List pizzas in sizes 'L' or 'XL'

Find pizzas priced between $15.00–$17.00

Find pizzas with "Chicken" in the name

Orders placed on '2015-02-15' or after 8 PM

📊 PHASE 3: Sales Performance & Business Insights (7 Questions)

Focus: Aggregations, grouping, joins, and intermediate analysis.

Total quantity of pizzas sold (SUM)

Calculate the average pizza price (AVG)

Compute order-wise revenue using joins

Total quantity sold per pizza category

Categories with more than 5,000 pizzas sold (HAVING)

Pizzas never ordered (LEFT/RIGHT JOIN)

Price differences between pizza sizes (SELF JOIN)

➕ ADDITIONAL INSIGHTS (8 Bonus Questions)

Total revenue generated

Top-selling pizza

Highest revenue-generating pizza category

Most frequently ordered size

Peak ordering hour

Monthly sales trend

Most common ingredients used across pizzas

Highest revenue day in the dataset

⭐ Key Takeaways (Collective Insights)

More than 49k pizzas were sold across all orders

Classic and Chicken pizzas dominate in both sales and revenue

Large (L) and Extra-Large (XL) sizes are most preferred

Order volume peaks between 6 PM – 9 PM

Weekends outperform weekdays, especially Saturdays

Several pizzas had missing or NULL data, which required cleaning

Some pizzas were never ordered, indicating low visibility or demand

Price scaling from S → XL is consistent, supporting price optimization

Ingredient analysis shows cheese-based and chicken-based pizzas are most popular

🛠️ Tech Stack

SQL (PostgreSQL/MySQL)

DB Schema Design

Data Cleaning Techniques

Aggregation & Joins

Query Optimization Basics
