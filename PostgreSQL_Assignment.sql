-- create a "books" table :
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    stock INTEGER NOT NULL CHECK (stock >= 0),
    published_year INTEGER NOT NULL CHECK (published_year > 1450 AND published_year <= EXTRACT(YEAR FROM CURRENT_DATE)) -- Assuming books were not published before 1450 and not in the future
    -- The CHECK constraint ensures that the published year is a valid year 
);

-- create a "customers" table :
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    joined_date DATE DEFAULT CURRENT_DATE
    );

-- create a "orders" table :
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    book_id INTEGER NOT NULL REFERENCES books(id) ON DELETE CASCADE,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    order_date DATE DEFAULT CURRENT_DATE
);


-- insert dummy data in the books table
INSERT INTO books (title, author, price, stock, published_year) VALUES
('The Pragmatic Programmer', 'Andrew Hunt', 40.00, 10, 1999),
('Clean Code', 'Robert C. Martin', 35.00, 5, 2008),
('You Don''t Know JS', 'Kyle Simpson', 30.00, 8, 2014),
('Refactoring', 'Martin Fowler', 50.00, 3, 1999),
('Database Design Principles', 'Jane Smith', 20.00, 0, 2018),
('Design Patterns', 'Erich Gamma', 45.00, 7, 1994),
('Eloquent JavaScript', 'Marijn Haverbeke', 25.00, 12, 2011),
('The Art of Computer Programming', 'Donald Knuth', 60.00, 2, 1968),
('Python Crash Course', 'Eric Matthes', 28.00, 15, 2015),
('SQL Cookbook', 'Anthony Molinaro', 38.00, 6, 2005);


-- get all books
SELECT * FROM books;

-- insert dummy data in the customers table
INSERT INTO customers (name, email, joined_date) VALUES
('Alice', 'alice@email.com', '2023-01-10'),
('Bob', 'bob@email.com', '2022-05-15'),
('Charlie', 'charlie@email.com', '2023-06-20'),
('Dave', 'dave@email.com', '2023-07-05'),
('Emma', 'emma@email.com', '2022-11-12'),
('Frank', 'frank@email.com', '2023-03-25');

-- get all customers
select * from customers;


-- insert dummy data in the orders table
INSERT INTO orders (customer_id, book_id, quantity, order_date) VALUES
(1, 2, 1, '2024-03-10'),
(2, 1, 1, '2025-02-20'),
(1, 3, 2, '2024-07-05'),
(3, 4, 1, '2025-01-15'),
(5, 7, 2, '2024-06-20');

-- get all orders
SELECT * FROM orders;

-- 1️⃣ Find books that are out of stock.
SELECT * FROM books WHERE stock = 0;

-- 2️⃣ Retrieve the most expensive book in the store.
SELECT * FROM books ORDER BY price DESC LIMIT 1;

-- 3️⃣ Find the total number of orders placed by each customer.
SELECT name, count(*) as total_order FROM orders
LEFT JOIN customers ON orders.customer_id = customers.id GROUP BY customers.name;

-- 4️⃣ Calculate the total revenue generated from book sales.
select SUM(books.price * orders.quantity) AS total_revenue from orders
LEFT JOIN books ON orders.book_id = books.id ;

-- 5️⃣ List all customers who have placed more than one order.
SELECT name, count(*) as orders_count FROM orders 
LEFT JOIN customers ON orders.customer_id = customers.id 
GROUP BY customers.name
HAVING count(*) > 1;

-- 7️⃣ Increase the price of all books published before 2000 by 10%.
UPDATE books SET price = price * 1.10 WHERE published_year < 2000;

-- 8️⃣ Delete customers who haven't placed any orders.
DELETE FROM customers WHERE id NOT IN (SELECT DISTINCT customer_id FROM orders);
