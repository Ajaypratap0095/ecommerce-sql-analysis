CREATE DATABASE ecommerce_db;
USE ecommerce_db;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50)
);

INSERT INTO Customers
(customer_name,email,phone,city)
VALUES
('Aditya Sharma','aditya@gmail.com','9876543210','Jaipur'),
('Priya Verma','priya@gmail.com','9876543211','Delhi'),
('Rahul Singh','rahul@gmail.com','9876543212','Mumbai'),
('Sneha Gupta','sneha@gmail.com','9876543213','Pune'),
('Aman Jain','aman@gmail.com','9876543214','Bangalore');

# Table 2 : Product

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

INSERT INTO Categories
(category_name)
VALUES
('Electronics'),
('Fashion'),
('Books'),
('Home Appliances');


# Table 3: Products

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10,2),
    stock INT,

    FOREIGN KEY(category_id)
    REFERENCES Categories(category_id)
);

INSERT INTO Products
(product_name,category_id,price,stock)
VALUES
('iPhone 15',1,79999,20),
('Samsung Galaxy S24',1,74999,15),
('Nike Running Shoes',2,4999,50),
('Data Science Handbook',3,899,100),
('Microwave Oven',4,12000,10),
('Bluetooth Headphones',1,2999,40);

# Table 4: Orders

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),

    FOREIGN KEY(customer_id)
    REFERENCES Customers(customer_id)
);

INSERT INTO Orders
(customer_id,order_date,total_amount)
VALUES
(1,'2026-06-01',82998),
(2,'2026-06-02',4999),
(3,'2026-06-02',899),
(4,'2026-06-03',12000),
(5,'2026-06-04',2999); 

# Table 5: Order_Items

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    item_total DECIMAL(10,2),

    FOREIGN KEY(order_id)
    REFERENCES Orders(order_id),

    FOREIGN KEY(product_id)
    REFERENCES Products(product_id)
);

INSERT INTO Order_Items
(order_id,product_id,quantity,item_total)
VALUES
(1,1,1,79999),
(1,6,1,2999),
(2,3,1,4999),
(3,4,1,899),
(4,5,1,12000),
(5,6,1,2999);

# Table 6: Payments

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT UNIQUE,
    payment_date DATE,
    payment_method VARCHAR(30),
    payment_status VARCHAR(20),

    FOREIGN KEY(order_id)
    REFERENCES Orders(order_id)
);

INSERT INTO Payments
(order_id,payment_date,payment_method,payment_status)
VALUES
(1,'2026-06-01','Credit Card','Completed'),
(2,'2026-06-02','UPI','Completed'),
(3,'2026-06-02','Debit Card','Completed'),
(4,'2026-06-03','Net Banking','Pending'),
(5,'2026-06-04','UPI','Completed');

SELECT * FROM Customers;

SELECT * FROM Categories;

SELECT * FROM Products;

SELECT * FROM Orders;

SELECT * FROM Order_Items;

SELECT * FROM Payments;

# Level 1: Basic SELECT Queries

### Q1. Display all customer details.

SELECT * FROM Customers;

### Q2. Display all products with their prices.

select product_name, price from products;

### Q3. Show all categories.
SELECT * FROM Categories;

### Q4. Display all orders placed after `2026-06-02`.
select order_id, order_date from orders
where order_date>'2026-06-02';

### Q5. Display products having stock greater than 20.
select product_name,stock from products
where stock>=20;

### Q6. Show products whose price is greater than ₹5000.
select product_name,price from products
where price> 5000;

### Q7. Display all payments with status 'Completed'.
select payment_id,payment_status from payments
where payment_status='completed';

### Q8. Display all customers from Jaipur.
select customer_name, city from customers
where city = 'Jaipur';

### Q9. Display product names in ascending order.
select product_name from products
order by product_name ASC;

### Q10. Display top 3 most expensive products.
select product_name, price from products
order by PRICE DESC LIMIT 3;

# Level 2: Filtering & Sorting

### Q11. Display products between ₹3000 and ₹80000.
select product_name, price from products
where price between 3000 and 80000;

### Q12. Show customers whose names start with 'A'.
select customer_name from customers
where customer_name like 'A%';

### Q13. Display products containing the word "Phone".
select product_name from products
where product_name like '%phone%';

### Q14. Display orders sorted by total amount in descending order.
select order_id, total_amount from orders
order by total_amount desc;

### Q15. Show customers who belong to Delhi or Mumbai.
select customer_name, city from customers
where city in ('Delhi','Mumbai');

# Level 3: Aggregate Functions

### Q16. Find the total number of customers.
select count(customer_name) from customers;

### Q17. Find the average product price.
select avg(price) from products;

### Q18. Find the highest priced product.
select max(price) from products;

### Q19. Find the minimum product price.
select min(price) from products;

### Q20. Calculate total inventory stock available.
select sum(stock) from products;

### Q21. Calculate total revenue generated from orders.
select sum(total_amount) as total_revenue from orders;

### Q22. Find total products available in each category.
select category_id, count(*) from products
group by category_id;

# Level 4: Joins

### Q23. Find total quantity sold for each product.
SELECT p.product_name, SUM(o.quantity) AS total_quantity_sold
FROM Products p
JOIN Order_Items o
ON p.product_id = o.product_id
GROUP BY p.product_name;

### Q24. Display customer names along with their order IDs.
select t1.customer_name, t2.order_id from customers as t1
inner join orders as t2
on t1.customer_id = t2.customer_id;

### Q25. Display order details along with customer names.
select t1.customer_name, t2.order_id, t2.order_date from customers as t1
inner join orders as t2
on t1.customer_id = t2.customer_id;

### Q26. Display product names along with category names.
select t1.category_name, t2.product_name from categories as t1
join products as t2
on t1.category_id = t2.category_id;

### Q27. Show customer name, product name, and quantity purchased.
SELECT c.customer_name,
       p.product_name,
       oi.quantity
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Order_Items oi
ON o.order_id = oi.order_id
JOIN Products p
ON oi.product_id = p.product_id;

### Q28. Display payment details with customer names.

SELECT c.customer_name,
       p.payment_id,
       p.payment_date,
       p.payment_method,
       p.payment_status
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Payments p
ON o.order_id = p.order_id;

### Q29.Display all products that have been ordered.
SELECT DISTINCT p.product_id,
                p.product_name
FROM Products p
JOIN Order_Items oi
ON p.product_id = oi.product_id;

### Q30. Display products that have never been ordered.
SELECT p.product_id,
       p.product_name
FROM Products p
LEFT JOIN Order_Items oi
ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

# Level 5: GROUP BY

### Q31. Find total spending by each customer.
SELECT c.customer_name,
       SUM(o.total_amount) AS total_spending
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

### Q32. Find total orders placed by each customer.
SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

### Q33. Find total revenue generated by each product.
SELECT p.product_name,
       SUM(oi.item_total) AS total_revenue
FROM Products p
JOIN Order_Items oi
ON p.product_id = oi.product_id
GROUP BY  p.product_name;

### Q34. Find total products in each category.
SELECT c.category_name,
       COUNT(p.product_id) AS total_products
FROM Categories c
LEFT JOIN Products p
ON c.category_id = p.category_id
GROUP BY c.category_name;

### Q35. Find total quantity sold category-wise.
SELECT c.category_name,
       SUM(oi.quantity) AS total_quantity_sold
FROM Categories c
JOIN Products p
ON c.category_id = p.category_id
JOIN Order_Items oi
ON p.product_id = oi.product_id
GROUP BY c.category_name;

### Q36. Find average order value for each customer.
SELECT c.customer_name,
       AVG(o.total_amount) AS avg_order_value
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

# Level 6: HAVING Clause

### Q37. Display customers whose total spending exceeds ₹10,000.
SELECT c.customer_name,
       SUM(o.total_amount) AS total_spending
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING SUM(o.total_amount) > 10000;

### Q38. Display products whose revenue exceeds ₹5,000.
SELECT p.product_name,
       SUM(oi.item_total) AS total_revenue
FROM Products p
JOIN Order_Items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
HAVING SUM(oi.item_total) > 5000;

### Q39. Display categories having more than one product.
SELECT c.category_name,
       COUNT(p.product_id) AS total_products
FROM Categories c
JOIN Products p
ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING COUNT(p.product_id) > 1;

### Q40. Display customers who placed more than one order.
SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 1;

# Level 7: Subqueries

### Q41. Find the most expensive product.
SELECT product_name, price
FROM Products
WHERE price = (
    SELECT MAX(price)
    FROM Products
);

### Q42. Find customers who spent more than the average spending.
SELECT c.customer_name,
       SUM(o.total_amount) AS total_spending
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING SUM(o.total_amount) >
(
    SELECT AVG(total_spending)
    FROM
    (
        SELECT SUM(total_amount) AS total_spending
        FROM Orders
        GROUP BY customer_id
    ) t
);

### Q43.Find products priced above the average product price.
SELECT product_name,
       price
FROM Products
WHERE price >
(
    SELECT AVG(price)
    FROM Products
);

### Q44. Find the customer who placed the highest-value order.
SELECT c.customer_name,
       o.total_amount
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
WHERE o.total_amount =
(
    SELECT MAX(total_amount)
    FROM Orders
);

### Q45. Find products that belong to the same category as 'iPhone 15'.
SELECT product_name
FROM Products
WHERE category_id =
(
    SELECT category_id
    FROM Products
    WHERE product_name = 'iPhone 15'
);
