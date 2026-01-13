-- Create Database
CREATE DATABASE OnlineBookstore;

USE OnlineBookstore;
-- Switch to the database


-- Create Tables
-- DROP TABLE IF EXISTS Books;
-- CREATE TABLE Books (
--     Book_ID SERIAL PRIMARY KEY,
--     Title VARCHAR(100),
--     Author VARCHAR(100),
--     Genre VARCHAR(50),
--     Published_Year INT,
--     Price NUMERIC(10, 2),
--     Stock INT
-- );

-- DROP TABLE IF EXISTS customers;
-- CREATE TABLE Customers (
--     Customer_ID SERIAL PRIMARY KEY,
--     Name VARCHAR(100),
--     Email VARCHAR(100),
--     Phone VARCHAR(15),
--     City VARCHAR(50),
--     Country VARCHAR(150)
-- );



-- DROP TABLE IF EXISTS orders;
-- CREATE TABLE Orders (
--     Order_ID SERIAL PRIMARY KEY,
--     Customer_ID INT REFERENCES Customers(Customer_ID),
--     Book_ID INT REFERENCES Books(Book_ID),
--     Order_Date DATE,
--     Quantity INT,
--     Total_Amount NUMERIC(10, 2)
-- );

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;



-- 1) Retrieve all books in the "Fiction" genre:

select * from books
where genre = 'Fiction';


-- 2) Find books published after the year 1950:
select * from books 
where Published_Year>1950;


-- 3) List all customers from the Canada:
select * from customers
where Country = 'canada';


-- 4) Show orders placed in November 2023:
SELECT * FROM Orders
WHERE Order_date between '2023-11-01' and '2023-11-30';


-- 5) Retrieve the total stock of books available:
select sum(Stock) as Total_Stock
from books;


-- 6) Find the details of the most expensive book:
select * from books
order by Price desc
limit 1;


-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders
where quantity > 1;


-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders
where Total_Amount > 20;


-- 9) List all genres available in the Books table:
select distinct genre
from books;


-- 10) Find the book with the lowest stock:
select * from books 
order by Stock asc
limit 1;


-- 11) Calculate the total revenue generated from all orders:
SELECT sum(total_amount) as Revenue 
FROM Orders;


-- Advance Questions : 


-- 1) Retrieve the total number of books sold for each genre:

 select * from orders;
 
select b.genre, sum(o.Quantity) as Total_books_sold
from orders o
join books b on o.Book_ID = b.Book_ID 
group by b.Genre;


-- 2) Find the average price of books in the "Fantasy" genre:

select * from books;
select avg(Price) as Average_Price
from books
where genre = 'Fantasy';


-- 3) List customers who have placed at least 2 orders:

select * from orders;
select o.Customer_ID, c.name, count(o.Order_ID) as order_count
from orders o
join customers c on o.Customer_ID = c.Customer_ID
group by o.Customer_ID, c.name
having count(Order_ID) >=2;


-- 4) Find the most frequently ordered book:

select o.Book_ID, b.title, count(o.Order_id) as order_count
from orders o
join books b on o.Book_ID  = b.Book_ID
group by o.Book_ID, b.title
order by order_count desc
limit 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

select * from books 
where Genre = 'fantasy'
order by Price desc
limit 3;


-- 6) Retrieve the total quantity of books sold by each author:

select b.Author, sum(o.Quantity) as Total_books_sold
from orders o 
join books b on o.Book_ID = b.Book_ID
group by Author;


-- 7) List the cities where customers who spent over $30 are located:

select distinct c.City, Total_Amount
from orders o 
join customers c on o.Customer_ID = c.Customer_ID
where o.total_amount > 30;


-- 8) Find the customer who spent the most on orders:

select c.Customer_ID, c.Name, sum(o.Total_Amount) as Total_Spent
from orders o 
join customers c on o.Customer_ID = c.Customer_ID
group by c.Customer_ID, c.Name
order by Total_Spent desc
limit 1; 


-- 9) Calculate the stock remaining after fulfilling all orders:

select b.Book_ID, b.Title, b.stock, coalesce(sum(o.Quantity), 0) as order_Quantity, 
b.stock- coalesce(sum(o.Quantity), 0) as Remaining_Quantity
from books b 
left join orders o on b.Book_ID = o.Book_ID
group by b.Book_ID, b.Title, b.stock
order by b.Book_ID;