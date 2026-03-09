-- ==========================================
-- PROJECT: Online Bookstore Database
-- DESCRIPTION: Database schema and queries
-- for managing books, customers, and orders
-- ==========================================


-- ==========================================
-- STEP 1: Create Database
-- ==========================================
CREATE DATABASE Assignment2;


-- ==========================================
-- STEP 2: Create Books Table
-- Stores information about books available
-- in the bookstore
-- ==========================================
DROP TABLE IF EXISTS Books;

CREATE TABLE Books (
Book_ID SERIAL PRIMARY KEY,        -- Unique ID for each book
Title VARCHAR (100),               -- Book title
AUTHOR VARCHAR (50),               -- Author name
Gener VARCHAR (50),                -- Genre of the book
Published_year INT,                -- Year of publication
Price NUMERIC(10,2),               -- Price of the book
Stock INT                          -- Available stock quantity
);

SELECT * FROM Books;



-- ==========================================
-- STEP 3: Create Customers Table
-- Stores customer information
-- ==========================================
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers(
Customer_ID SERIAL PRIMARY KEY,    -- Unique customer ID
Name VARCHAR(100),                 -- Customer name
Email VARCHAR (100),               -- Customer email
Phone VARCHAR (15),                -- Phone number
City VARCHAR (50),                 -- City of customer
Country VARCHAR (150)              -- Country of customer
);

SELECT * FROM Customers;



-- ==========================================
-- STEP 4: Create Orders Table
-- Stores book purchase transactions
-- ==========================================
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
Order_ID SERIAL PRIMARY KEY,       -- Unique order ID
Customer_ID INT REFERENCES Customers (Customer_ID),  -- Customer who placed order
Book_ID INT REFERENCES Books (Book_ID),              -- Book ordered
Order_Date DATE,                   -- Date of order
Quantity INT,                      -- Number of books ordered
Total_Amount NUMERIC(10,2)         -- Total price paid
);

SELECT * FROM Orders;



-- ==========================================
-- STEP 5: Import Data from CSV Files
-- ==========================================

-- Import book data
COPY Books(Book_ID, Title, Author, Gener, Published_year, Price, Stock)
FROM 'D:/Jeyasi/SQL Tutorial/Books.csv'
DELIMITER ','
CSV HEADER;

-- Import customer data
COPY Customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'D:/Jeyasi/SQL Tutorial/Customers.csv'
DELIMITER ','
CSV HEADER;

-- Import order data
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
FROM 'D:/Jeyasi/SQL Tutorial/Orders.csv'
DELIMITER ','
CSV HEADER;


-- Verify imported data
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;



-- ==========================================
-- BASIC QUERIES
-- ==========================================

-- 1) Retrieve all books in the "Fiction" genre
SELECT * FROM Books
WHERE gener = 'Fiction';


-- 2) Find books published after 1950
SELECT * FROM Books
WHERE published_year > 1950;


-- 3) List all customers from Canada
SELECT * FROM Customers
WHERE country = 'Canada';


-- 4) Show orders placed in November 2023
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';


-- 5) Show customers who ordered more than 1 book quantity
SELECT * FROM Orders
WHERE quantity > 1;


-- 6) Retrieve total stock available in bookstore
SELECT SUM(stock) AS Total_Stock
FROM Books;


-- 7) Find the most expensive book
SELECT *
FROM Books
ORDER BY price DESC
LIMIT 1;


-- 8) Retrieve orders where total amount exceeds $20
SELECT * FROM Orders
WHERE total_amount > 20;


-- 9) List all available book genres
SELECT DISTINCT gener
FROM Books;


-- 10) Find book with lowest stock
SELECT *
FROM Books
ORDER BY stock
LIMIT 1;



-- ==========================================
-- ADVANCED QUERIES
-- ==========================================

-- 1) Retrieve total number of books sold for each genre
SELECT b.gener,
       SUM(o.quantity) AS Total_books_sold
FROM Orders o
JOIN Books b
ON o.book_id = b.book_id
GROUP BY b.gener;



-- 2) Find the average price of books in the Fantasy genre
SELECT AVG(price) AS Average_Price
FROM Books
WHERE gener = 'Fantasy';



-- 3) List customers who placed at least 2 orders
-- (Note: counting orders per customer)
SELECT c.name,
       COUNT(o.order_id) AS order_count
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COUNT(o.order_id) >= 2;



-- 4) Find the most frequently ordered books
SELECT o.book_id,
       b.title,
       SUM(o.quantity) AS order_count
FROM Orders o
JOIN Books b
ON o.book_id = b.book_id
GROUP BY o.book_id, b.title
ORDER BY order_count DESC;



-- 5) Show top 3 most expensive Fantasy books
SELECT *
FROM Books
WHERE gener = 'Fantasy'
ORDER BY price DESC
LIMIT 3;



-- 6) Retrieve total quantity of books sold by each author
SELECT b.author,
       SUM(o.quantity) AS total_books_sold
FROM Orders o
JOIN Books b
ON o.book_id = b.book_id
GROUP BY b.author;



-- 7) List cities where customers spent more than $300
SELECT DISTINCT c.city
FROM Orders o
JOIN Customers c
ON c.customer_id = o.customer_id
WHERE o.total_amount > 300;



-- 8) Find the customer who spent the most
SELECT c.name,
       SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 1;



-- 9) Calculate remaining stock after fulfilling orders
SELECT b.title,
       b.stock AS total_stock,
       COALESCE(SUM(o.quantity),0) AS total_ordered,
       b.stock - COALESCE(SUM(o.quantity),0) AS remaining_stock
FROM Books b
LEFT JOIN Orders o
ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock;