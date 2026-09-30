Data Analytics Internship – Task 23 (SQL Window Functions)

This repository contains my submission for Task 23 of the Data Analytics Internship.

Dataset - Northwind Dataset

Objective - The objective was to understand and apply SQL window functions such as ROW_NUMBER, RANK, DENSE_RANK, and LAG for business-related analysis.

Tools Used
1. DB Browser for SQLite
2. Northwind Dataset
3. GitHub

SQL Window Function Analysis
1. Used the Northwind dataset containing order and order-detail information.
2. Used the northwind_orders table for order-level analysis.
3. Used the northwind_order_details table for product and order-detail analysis.
4. Used ROW_NUMBER to number customer orders chronologically.
5. Used ROW_NUMBER to number items within each order.
6. Used RANK to rank orders based on freight and order value.
7. Compared RANK and DENSE_RANK to understand their difference when ranking values.
8. Used LAG to identify previous customer orders and compare previous values.
9. Calculated the number of days between consecutive customer orders.
10. Compared monthly sales with the previous month's sales.
11. Ranked high-value orders within each customer.
12. Ranked customers based on their total sales value.
13. Created 12 SQL queries and recorded their outputs.

Files
1. Task 23.sql - Contains all 12 SQL window function queries
2. Task 23.db - SQLite database used for the analysis
3. Notes.txt - Notes explaining the purpose of each query
4. Output 1.PNG to Output 12.PNG - Screenshots of the query results
5. README.md - Summary of the SQL window function analysis

Conclusion - SQL window functions were successfully applied to the Northwind dataset for sequencing, ranking, and comparing data across rows and time periods. The analysis provided practical understanding of ROW_NUMBER, RANK, DENSE_RANK, and LAG and their use in business-related SQL analysis.
