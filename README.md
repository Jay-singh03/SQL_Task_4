# SQL_Task_4

1.Apply aggregate functions on numeric columns

* Aggregation functions(COUNT, SUM, MIN, MAX, AVG) with 'unit_price' in Order Items table
* Aggregation functions(COUNT, SUM, MIN, MAX, AVG) with 'total_amount' in Orders table
* Aggregation functions(COUNT, SUM, MIN, MAX, AVG) with 'stock_quanity' and 'price' in Products table


2.Use GROUP BY to categorize
* By 'order_id' column in Order Items table
* By 'customer_id' column in Orders table
* By 'product_name' column in Products table


3.Filter groups using HAVING

* With condition 'sum(unit_price) > 150;' in Order Items table
* With condition 'sum(total_amount) > 250;' in Orders table
* With condition 'product_available < 50;' in Products table
