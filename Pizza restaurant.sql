-- Create table
-- Table customer
CREATE TABLE customers (
 customerid int,
 name varchar,
 phone varchar,
 gender varchar,
 age int
);

INSERT INTO customers values
 (1, 'Eye', '0999995555', 'F', 24),
 (2, 'Frong', '0988884444', 'M', 25),
 (3, 'Bew', '0977773333', 'F', 40),
 (4, 'Amy', '0966662222', 'F', 15),
 (5, 'Armer', '0955551111', 'M', 50);


SELECT * FROM customers;

-- Table order
CREATE TABLE orders (
 orderid int,
 customerid int,
 productid int,
 orderdate date
);

INSERT INTO orders values
 (001, 1, 02, '2023-11-08'),
 (002, 2, 05, '2023-10-01'),
 (003, 3, 01, '2022-12-30'),
 (004, 4, 04, '2023-09-06'),
 (005, 5, 03, '2022-10-15');


SELECT * FROM orders;

-- Table menus
CREATE TABLE menus (
 productid int,
 productname varchar,
 productprice int
);

INSERT INTO menus values
 (01, 'Hawaiian', 120),
 (02, 'Pepperoni', 100),
 (03, 'Double cheese', 150),
 (04, 'Meat lover', 120),
 (05, 'Vegetarian', 80);


SELECT * FROM menus;

-- Join table

SELECT
  customers.name,
  menus.productname,
  orders.orderdate
FROM customers
JOIN orders ON customers.customerid = orders.customerid
JOIN menus ON orders.productid = menus.productid;

-- Subqueries or WITH
-- find customer who purchase in 2023

WITH purchase_2023 AS (
  SELECT * FROM orders
  WHERE STRFTIME('%Y', orderdate) = '2023'
), customers_2023 AS (
   SELECT * FROM customers
)

SELECT 
  name, gender, age
FROM customers_2023 t1
JOIN purchase_2023 t2 ON t1.customerid = t2.customerid
GROUP BY name;

-- find top 3 customer who bought most expensive pizza

SELECT
  customers.name,
  orders.orderid,
  menus.productid,
  menus.productname,
  menus.productprice
FROM customers
JOIN orders ON customers.customerid = orders.customerid
JOIN menus ON orders.productid = menus.productid
GROUP BY customers.name
ORDER BY menus.productprice DESC
LIMIT 3;