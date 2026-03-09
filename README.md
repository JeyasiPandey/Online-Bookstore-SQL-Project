# 📚 Online Bookstore SQL Project

## 📌 Project Overview

This project demonstrates the **design and analysis of a relational database for an Online Bookstore using SQL**.
The database manages **books inventory, customer information, and order transactions**, allowing analytical queries to generate useful business insights.

The project showcases **database schema design, data loading from CSV files, and SQL queries for data analysis**.

---

## 🗂 Repository Structure

```
Online-Bookstore-SQL-Project
│
├── README.md
├── bookstore_database.sql
├── datasets
│   ├── Books.csv
│   ├── Customers.csv
│   └── Orders.csv
│
└── images
    └── ER_Diagram.png
```

---

## 🧩 Database Schema

The database consists of **three main tables**:

### 1️⃣ Books

Stores information about books available in the bookstore.

| Column         | Description                     |
| -------------- | ------------------------------- |
| Book_ID        | Unique identifier for each book |
| Title          | Book title                      |
| Author         | Author of the book              |
| Genre          | Category of the book            |
| Published_Year | Year the book was published     |
| Price          | Price of the book               |
| Stock          | Available inventory             |

---

### 2️⃣ Customers

Stores information about bookstore customers.

| Column      | Description                |
| ----------- | -------------------------- |
| Customer_ID | Unique customer identifier |
| Name        | Customer name              |
| Email       | Email address              |
| Phone       | Phone number               |
| City        | Customer city              |
| Country     | Customer country           |

---

### 3️⃣ Orders

Stores book purchase transactions.

| Column       | Description                   |
| ------------ | ----------------------------- |
| Order_ID     | Unique order identifier       |
| Customer_ID  | Customer who placed the order |
| Book_ID      | Book ordered                  |
| Order_Date   | Date of order                 |
| Quantity     | Number of books ordered       |
| Total_Amount | Total order value             |

---

## 🔗 Entity Relationships

The database follows these relationships:

* **Customers → Orders** (One-to-Many)
* **Books → Orders** (One-to-Many)

This means:

* A customer can place **multiple orders**
* A book can appear in **multiple orders**

---

## 🗃 ER Diagram

The database structure is illustrated below:

![ER Diagram](images/ER_Diagram.png)

---

## 📊 Example SQL Queries

### Most Frequently Ordered Books

```sql
SELECT b.title,
       SUM(o.quantity) AS order_count
FROM Orders o
JOIN Books b
ON o.book_id = b.book_id
GROUP BY b.title
ORDER BY order_count DESC;
```

---

### Customer Who Spent the Most

```sql
SELECT c.name,
       SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 1;
```

---

### Remaining Stock After Orders

```sql
SELECT b.title,
       b.stock AS total_stock,
       COALESCE(SUM(o.quantity),0) AS total_ordered,
       b.stock - COALESCE(SUM(o.quantity),0) AS remaining_stock
FROM Books b
LEFT JOIN Orders o
ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock;
```

---

## 📈 Key Insights from the Data

* Identify **best-selling books**
* Determine **top spending customers**
* Analyze **sales by genre and author**
* Track **inventory after fulfilling orders**

---

## 🛠 Technologies Used

* SQL
* PostgreSQL
* CSV datasets
* GitHub

---

## 🎯 Skills Demonstrated

* Relational database design
* SQL joins and aggregations
* Data analysis using SQL
* Data organization and documentation
* GitHub project management

---

## 👨‍💻 Author

**Jeyasi Pandey**

This project is part of a **SQL and database portfolio for learning data analysis and database design**.
