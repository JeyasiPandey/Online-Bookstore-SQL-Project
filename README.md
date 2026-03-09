# Online Bookstore SQL Project

## Project Overview
This project demonstrates the design and analysis of a relational
database for an online bookstore using SQL.

The database manages books inventory, customer information,
and order transactions.

## Database Tables
Books – Stores information about books available in inventory  
Customers – Stores customer details  
Orders – Stores purchase transactions

## Features
• Database schema design  
• Data import from CSV files  
• Analytical SQL queries  
• Business insights from bookstore data

## Example SQL Queries

Most frequently ordered books

SELECT b.title,
       SUM(o.quantity) AS order_count
FROM Orders o
JOIN Books b
ON o.book_id = b.book_id
GROUP BY b.title
ORDER BY order_count DESC;

Customer who spent the most

SELECT c.name,
       SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 1;

## Technologies Used
SQL  
PostgreSQL  
GitHub

## Author
Anand Prakash
