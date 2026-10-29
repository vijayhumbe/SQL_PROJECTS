-- Create Database
CREATE DATABASE OnlineBookstore;

-- Switch to the database

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

 

-- 1) Retrieve all books in the "Fiction" genre:
select * from Books where Genre = 'Fiction';

-- 2) Find books published after the year 1950:
select * from Books where Published_Year > 1950;

-- 3) List all customers from the Canada:
select * from customers where Country = 'Canada';

-- 4) Show orders placed in November 2023:
select * from orders where Order_date between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available:
select sum(stock) as total_stock from books;

-- 6) Find the details of the most expensive book:
select * from books order by price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders where Quantity >1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders where Total_Amount>20;

-- 9) List all genres available in the Books table:
select distinct(Genre) from books;

-- 10) Find the book with the lowest stock:
select*from books order by stock limit 1;

-- 11) Calculate the total revenue generated from all orders:
select sum(Total_Amount) as total_revenue from orders; 

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
select b.Genre , sum(o.Quantity) as total_books from orders o 
join books b on o.book_id = b.book_id group by b.Genre ;

-- 2) Find the average price of books in the "Fantasy" genre:
select Genre ,avg(price)as avg_price from books where Genre = 'Fantasy';


-- 3) List customers who have placed at least 2 orders:
select o.customer_id ,c.name, count(o.order_id) as total_order  from orders as o 
join customers as c on o.customer_id = c.customer_id  group by c.name,o.customer_id having count(o.order_id) >=2;

-- 4) Find the most frequently ordered book:
select b.book_id,b.Title,count(o.order_id) as order_count from orders o
join books b on o.book_id = b.book_id
group by o.book_id,b.Title
order by order_count desc limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books where genre = 'Fantasy' order by price desc limit 3;

-- 6) Retrieve the total quantity of books sold by each author:
select b.Author , sum(o.Quantity) as total_books_sold from orders as o
 join books as b on o.book_id = b.book_id group by b.Author ;

-- 7) List the cities where customers who spent over $30 are located:
select distinct c.city, Total_Amount from orders o 
join customers c on o.customer_id = c.customer_id where o.Total_Amount >30;

-- 8) Find the customer who spent the most on orders:
select c.customer_id,c.name,sum(o.Total_Amount) as most_spent_ammount_by_customer from orders o
join customers c on o.customer_id = c.customer_id 
group by c.name ,c.customer_id
order by most_spent_ammount_by_customer desc limit 1 ;

-- 9) Calculate the stock remaining after fulfilling all orders:
SELECT 
    b.book_id, 
    b.Title, 
    b.Stock AS original_stock,
    COALESCE(SUM(o.Quantity), 0) AS total_ordered,
    (b.Stock - COALESCE(SUM(o.Quantity), 0)) AS stock_remaining
FROM books AS b 
LEFT JOIN orders AS o ON b.book_id = o.book_id
GROUP BY b.book_id, b.Title, b.Stock
ORDER BY book_id;


