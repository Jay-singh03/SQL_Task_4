create database E_commerce;
use E_commerce;

############################       TASK 1       #################################################
# 1. Category Table creation....
create table categories(
	category_id int auto_increment primary key,
    category_name varchar(100) not null,
    description text
);

# Insert Categories....
insert into categories(category_name, description)
values('Electronic', 'Gadgets, devices and electronic accessories'),
('Clothing', 'Fashion items including shirts, pants, and accessories'),
('Books', 'Fiction, non-fiction, educational books'),
('Home & Kitchen', 'Home appliances and kitchen utensils');

# 2. Products Table creation....
create table products(
	product_id int auto_increment primary key,
    product_name varchar(225) not null,
    description text,
    price decimal(10, 2) not null check(price >= 0),
    stock_quantity int not null check(stock_quantity >= 0),
    category_id int,
    created_at timestamp default current_timestamp,
    foreign key (category_id) references categories(category_id) on delete set null
);

# Insert Products....
insert into products (product_name, description, price, stock_quantity, category_id)
values('Smartphone X', 'Latest smartphone with high-resolution camera', 699.99, 50, 1),
('Wireless Headphones', 'Noise-cancelling Bluetooth headphones', 199.99, 100, 1),
('Cotton T-Shirt', 'Comfortabe 100% cotton t-shirt', 24.99, 200, 2),
('Programming Book', 'Complete guide to web development', 49.99, 75, 3),
('Coffee Maker', 'Automatic drip coffee machine', 89.99, 30, 4),
('Laptop Stand', 'Adjustable aluminum laptop stand', 39.99, 60, 1),
('Jeans', 'Classic blue denim jeans', 59.99, 80, 2),
('Cookbook', 'Healthy recipes for everyday cooking', 29.99, 40, 3);

# 3. Customers Table creation....alter
create table customers(
	customer_id int auto_increment primary key,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    email varchar(255) unique not null,
    phone varchar(20),
    address text,
    created_at timestamp default current_timestamp
);

# Insert Customers....
insert into customers (first_name, last_name, email, phone, address)
values('John', 'Due', 'john.doe@email.com', '123-456-7890', '123 Main St, New York, NY'),
('Jane', 'Smith', 'jane.smith@email.com', '123-456-7891', '456 Oak Ave, Los Angeles, CA'),
('Mike', 'Johnson', 'mike.johnson@email.com', '123-456-7892', '789 Pine Rd, Chicago, IL'),
('Sarah', 'Wilson', 'sarah.wilson@email.com', '123-456-7893', '321 Elm St, Miami, FL');

# 4. Orders Table creation....
create table orders(
	order_id int auto_increment primary key,
    customer_id int not null,
    order_date timestamp default current_timestamp,
    total_amount decimal(10, 2) not null check(total_amount >= 0),
    status enum('pending', 'processing', 'shipped', 'delivered', 'cancelled') default 'pending',
    shipping_address text,
    foreign key(customer_id) references customers(customer_id) on delete cascade
);

# Insert Orders....
insert into orders (customer_id, total_amount, status, shipping_address)
values(1, 749.98, 'delivered', '123 Main St, New York, NY'),
(2, 149.98, 'processing', '456 Oak Ave, Los Angeles, CA'),
(3, 169.97, 'shipped', '789 Pine Rd, Chicago, IL'),
(1, 39.99, 'pending', '123 Main St, New York, NY'),
(4, 209.97, 'delivered', '321 Elm St, Miami, FL');

# 5. Order Items Tabel creation....
create table order_items(
	order_item_id int auto_increment primary key,
    order_id int not null,
    product_id int not null,
    quantity int not null check (quantity > 0),
    unit_price decimal(10, 2) not null check (unit_price >= 0),
    foreign key (order_id) references orders(order_id) on delete cascade,
    foreign key (product_id) references products(product_id) on delete cascade,
    unique key (order_id, product_id) # Prevents duplicate products in same order
);

# Insert Order Items....
insert into order_items (order_id, product_id, quantity, unit_price)
values(1, 1, 1, 699.99), # Order 1; Smartphone X
(1, 3, 2, 24.99),        # Order 1: 2 Cotton T-Shirts
(2, 2, 1, 199.99),       # Order 2: Wireless Headphones (corrected price)
(2, 6, 1, 39.99),        # Order 2: Laptop Stand (corrected price)
(3, 4, 1, 49.99),        # Order 3: Programming Book
(3, 8, 1, 29.99),        # Order 3: Cookbook
(3, 3, 3, 24.99),        # Order 3: 3 Cotton T-Shirts
(4, 6, 1, 39.99),        # Order 4: Laptop Stand
(5, 5, 1, 89.99),        # Order 5: Coffee Maker
(5, 2, 1, 199.99),       # Order 5: Wireless Headphones (corrected price)
(5, 7, 1, 59.99);        # Order 5: Jeans


############################       TASK 2       #################################################
#################################################################################################
-- =========================================================================================
-- 1. USE INSERT INTO FOR ADDING ROWS
-- =========================================================================================

# Insert wiht null values into categories....
insert into categories (category_name, description)
values('sports', NULL),
('Health', 'Dettol, paracetamol');


# Insert wiht null values into products....
insert into products (product_name, description, price, stock_quantity, category_id)
values('T-shirt', NULL, 24.99, 100, 2),
('Garden Hose', NULL, 39.99, 30, 4);


# Insert wiht null values into customers....
insert into customers(first_name, last_name, email, phone, address)
values('Jenea', 'Duge', 'jenea.duge@email.com', NULL,'335 Amk Ocg, Los Angea'),
('Sarah', 'Smith', 'sarah.smith@email.com', '485-893-3342', NULL);


# Insert wiht null values into Orders....
insert into orders (customer_id, total_amount, status, shipping_address)
values(3, 89.98, DEFAULT, NULL),
(4, 29.99, 'delivered', '789 Pine St, Chicago');


# Insert wiht null values into Order Items....
insert into order_items( order_id, product_id, quantity, unit_price)
values(2, 4, 2, 39.99),
(4, 5, 1, 29.99);


-- =========================================================================================
-- 2. HANDLE MISSING VALUES USING NULL OR DEFAULT
-- =========================================================================================

-- Display categories with null descriptions and handle them
select
	category_id,
    category_name,
    ifnull(description, 'No description available') AS description
from categories;

-- Display products with NULL descriptions and handle them
select
	product_id,
    product_name,
    ifnull(description, 'No description available') AS description,
    price,
    stock_quantity
From products;


-- Display customers with Null contact information
select
	customer_id,
    first_name,
    last_name,
    email,
    coalesce(phone, 'No phone provided') AS phone,
    coalesce(address, 'Address not specified') AS address
from customers;


-- Display orders wiht NULL shipping addresses
select
	order_id,
    customer_id,
    total_amount,
    status,
    ifnull(shipping_address, 'Use nilling addresses') AS shipping_address
from orders;


-- =========================================================================================
-- 3. UPDATE AND DELETE WITH WHERE CONDITIONS
-- =========================================================================================

# Table Categories
-- Deleting the rows where description is null....
delete from categories
where description is null;

-- ------------------------------------------------------------------------------------------
# Table Customers
-- update the phone column using email....
update customers
set phone = '626-986-5748'
where email = 'jenea.duge@email.com';

-- update the address column using email....
update customers
set address = '123 Akj Rhd, Iow Rogea'
where email = 'sarah.smith@email.com';


-- ---------------------------------------------------------------------------------------------
# Table Order Items
-- Delete the row if quantity column will null value....
delete from order_items
where quantity is null;


-- ---------------------------------------------------------------------------------------------
# Table Orders
-- updating the address column...
update orders 
set shipping_address = '526 Kap Wr, Aimne, UE'
where order_id = 8 and customer_id = 3;


-- ---------------------------------------------------------------------------------------------
# Table Products
-- Deleting the row where description is null....
delete from products
where description is null;


#################################################################################################
############################       TASK 3       #################################################
#################################################################################################

-- ==============================================================================================
-- 1.Use SELECT * and specific columns
-- ==============================================================================================

# Table Categories
select * from categories;
-- ------------------------------------------------------------------


# Table Customers
select first_name, last_name, email, phone 
from customers;
-- ------------------------------------------------------------------


# Table Order Items
select order_id, product_id, quantity, unit_price 
from order_items;
-- ------------------------------------------------------------------


# Table Orders
select customer_id, status, total_amount, shipping_address 
from orders;

-- ------------------------------------------------------------------


# Table Products
select product_name, stock_quantity, price, created_at 
from products;

-- ------------------------------------------------------------------


-- ==============================================================================================
-- 2.Apply WHERE, AND, OR, LIKE, BETWEEN
-- ==============================================================================================

# Table categories
-- Use of 'OR'
select * from categories
where category_name = 'Home Decor' or category_name = 'Home & Kitchen';

-- Use of 'AND' and ' 'LIKE'
select * from categories
where description like 'Exercise%' and category_name = 'Sports & Fitness';

-- ----------------------------------------------------------------------------------------


# Table Customers
-- Use of 'AND'
select * from customers
where first_name = 'Sarah' and last_name = 'Wilson';

-- use of 'LIKE'
select * from customers
where phone like '123%';

-- ----------------------------------------------------------------------------------------


# Table Order Items
-- Use of 'BETWEEN'
select * from order_items
where unit_price between 40 and 100;

-- Use of 'AND'
select * from order_items
where unit_price >30 and quantity <3;

-- ----------------------------------------------------------------------------------------


# Table Orders
-- Use of 'BETWEEN' and 'AND'
select * from orders
where total_amount between 100 and 600 and status = 'processing';

-- Use of 'LIKE'
select * from orders 
where shipping_address like '789%';

-- ----------------------------------------------------------------------------------------


# Table Products
-- Use of 'BETWEEN'
select * from products
where price between 200 and 700;

-- Use of 'OR'
select * from products 
where price < 100 or stock_quantity > 35;

-- ----------------------------------------------------------------------------------------


-- ==============================================================================================
-- 3.Sort with ORDER BY
-- ==============================================================================================

# Table Categories
select * from categories
order by category_name;

-- ----------------------------------------------------------------------------------------


# Table Customers
select * from customers
order by first_name;

-- ----------------------------------------------------------------------------------------


# Table Order Items
select * from order_items
order by unit_price desc;

-- ----------------------------------------------------------------------------------------

# Table Orders
select * from orders
order by total_amount desc;

-- ----------------------------------------------------------------------------------------


# Table Products
select * from products
order by stock_quantity desc
limit 3;

-- ----------------------------------------------------------------------------------------


#################################################################################################
############################       TASK 4       #################################################
#################################################################################################

-- ==============================================================================================
-- 1.Apply aggregate functions on numeric columns
-- ==============================================================================================

# Aggregation function in Order Items table

-- COUNT
select count(unit_price) as order_list
from order_items;

-- SUM
select sum(unit_price) as total_sale
from order_items;

-- MIN
select min(unit_price) as min_sale
from order_items;

-- MAX
select max(unit_price) as max_sale
from order_items;

-- AVG
select avg(unit_price) as avg_sale
from order_items;

----------------------------------------------------------------------------

# Aggregation function in Orders table
 
 -- COUNT
select count(total_amount) as total_amount
from orders;

-- SUM
select sum(total_amount) as total_amount
from orders;

-- MIN
select min(total_amount) as min_amount
from orders;

-- MAX
select max(total_amount) as max_amount
from orders;

-- AVG
select avg(total_amount) as avg_amount
from orders;


# Aggregation function in Products table

-- COUNT
select count(product_name) as total_products
from products;

-- SUM
select sum(stock_quantity) as total_stock_available, sum(price) as total_price
from products;

-- MIN
select min(stock_quantity) as min_product_stock_available, min(price) as cheap_price
from products;

-- MAX
select max(stock_quantity) as max_product_stock_available, max(price) as max_price
from products;

-- AVG
select avg(stock_quantity) as avg_product_stock_available, avg(price) as avg_price
from products;


-- ==============================================================================================
-- 2.Use GROUP BY to categorize
-- ==============================================================================================

# Table Order Items

select order_id, sum(quantity), sum(unit_price)
from order_items
group by order_id;

-- --------------------------------------------------------------------------------


# Table Orders

select customer_id, sum(total_amount)
from orders
group by customer_id;

-- --------------------------------------------------------------------------------


# Table Products

select product_name, sum(stock_quantity) as product_available, sum(price) as total_price
from products
group by product_name;

-- --------------------------------------------------------------------------------


-- ==============================================================================================
-- 3.Filter groups using HAVING
-- ==============================================================================================

# Table Order Items

select order_id, sum(quantity), sum(unit_price)
from order_items
group by order_id
having sum(unit_price) > 150;

-- --------------------------------------------------------------------------------


# Table Orders

select customer_id, sum(total_amount)
from orders
group by customer_id
having sum(total_amount) > 250;

-- --------------------------------------------------------------------------------


# Table Products

select product_name, sum(stock_quantity) as product_available, sum(price) as total_price
from products
group by product_name
having product_available < 50;

-- --------------------------------------------------------------------------------