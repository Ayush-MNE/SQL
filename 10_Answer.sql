create database sql_assignment;
use sql_assignment;
create table employees (
emp_id int primary key,
emp_name varchar(100) not null,
age int check (age>=18),
email varchar(90)  unique,
salary decimal default 30000);

select * from employees;
SELECT CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'sql_assignment';
ALTER TABLE employees DROP CHECK employees_chk_1;
alter table employees change column age new_age int;
alter table employees add check (new_age >=20);
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2));

alter table products add constraint primarykey1 primary key (product_id);
alter table products change column price price decimal (10,2) default 50;
CREATE TABLE Classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL
);

INSERT INTO Classes (class_id, class_name) VALUES
(101, 'Math'),
(102, 'Science'),
(103, 'History');

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

INSERT INTO Students (student_id, student_name, class_id) VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 101);

select student_name, class_name from classes c inner join students s on c.class_id = s.class_id;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL
);

INSERT INTO Customers (customer_id, customer_name) VALUES
(101, 'Alice'),
(102, 'Bob');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders (order_id, order_date, customer_id) VALUES
(1, '2024-01-01', 101),
(2, '2024-01-03', 102);

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Product (product_id, product_name, order_id) VALUES
(1, 'Laptop', 1),
(2, 'Phone', NULL);

select o.order_id, c.customer_name, p.product_name from orders o inner join customers c on o.customer_id = c.customer_id right join product p on o.order_id = p.order_id;

CREATE TABLE new_Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);

INSERT INTO new_Products (product_id, product_name) VALUES
(101, 'Laptop'),
(102, 'Phone');
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES new_Products(product_id)
);
INSERT INTO Sales (sale_id, product_id, amount) VALUES
(1, 101, 500.00),
(2, 102, 300.00),
(3, 101, 700.00);

select n.product_id, sum(amount) from sales s inner join new_products n on n.product_id = s.product_id group by product_id;
CREATE TABLE new_Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL
);

INSERT INTO new_Customers (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob');
CREATE TABLE new_Orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES new_Customers(customer_id)
);

INSERT INTO new_Orders (order_id, order_date, customer_id) VALUES
(1, '2024-01-02', 1),
(2, '2024-01-05', 2);

CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES new_Orders(order_id)
);

INSERT INTO Order_Details (order_id, product_id, quantity) VALUES
(1, 101, 2),
(1, 102, 1),
(2, 101, 3);

select  nr.order_id, customer_name, quantity from new_orders nr inner join new_Customers nc on nc.customer_id = nr.customer_id inner join Order_Details od on nr.order_id = od.order_id;
