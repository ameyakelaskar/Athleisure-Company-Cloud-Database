--down
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_o_supplier_id')
ALTER TABLE orders
    DROP CONSTRAINT fk_o_supplier_id
--IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_o_order_cart_id')
--ALTER TABLE orders
--   DROP CONSTRAINT fk_o_order_cart_id
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_o_order_product_id')
alter table orders
    drop CONSTRAINT fk_o_order_product_id
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_o_order_customer_id')
alter table orders
    drop CONSTRAINT fk_o_order_customer_id
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_o_order_product_name')
alter table orders
    drop CONSTRAINT fk_o_order_product_name
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_py_payments_employee_id' )
alter table payments 
    drop CONSTRAINT fk_py_payments_employee_id
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_py_payments_order_id')
alter table payments
    drop CONSTRAINT fk_py_payments_order_id  
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_ct_cart_customer_id')
alter table carts
    drop CONSTRAINT fk_ct_cart_customer_id
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_ct_cart_product_id')
alter table carts 
    drop CONSTRAINT fk_ct_cart_product_id 
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_ct_cart_order_id')
alter table carts 
    drop CONSTRAINT fk_ct_cart_order_id
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_product_supplier_id')
alter table products
    drop CONSTRAINT fk_product_supplier_id  
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='pk_o_order_id')
alter table orders
    drop CONSTRAINT pk_o_order_id
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='u_o_order_id')
alter table orders
    drop CONSTRAINT u_o_order_id
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='pk_c_customer_id')
alter table customers   
    drop CONSTRAINT pk_c_customer_id
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='u_c_customer_id' )
alter table customers
    drop CONSTRAINT u_c_customer_id
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='pk_s_supplier_number')
alter table suppliers
    drop constraint pk_s_supplier_number
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='u_s_supplier_id')
alter table suppliers
    drop CONSTRAINT u_s_supplier_id
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='u_s_supplier_name')
alter table suppliers
    drop CONSTRAINT u_s_supplier_name
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='pk_p_product_id')
alter table products
    drop CONSTRAINT pk_p_product_id
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='u_p_product_name')
alter table products 
    drop constraint u_p_product_name
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='pk_e_employee_id')
alter table employees
    drop CONSTRAINT pk_e_employee_id
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='pk_py_payment_number')
alter table payments
    drop constraint pk_py_payment_number
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='u_py_payment_id')
alter table payments
    drop CONSTRAINT u_py_payment_id
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='pk_ct_cart_number')
alter table carts 
    drop CONSTRAINT pk_ct_cart_number
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='u_ct_cart_id')
alter table carts 
    drop CONSTRAINT u_ct_cart_id
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='pk_ct_cart_id')
alter table carts 
    drop CONSTRAINT pk_ct_cart_id
GO

--Down-UP
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='customers')
DROP TABLE customers
GO

create table customers
(
    c_customer_id INT not null,
    c_customer_firstname VARCHAR(50) not null,
    c_customer_lastname VARCHAR(50) not null,
    c_customer_housenumber VARCHAR(20) not null,
    c_customer_street varchar(20) not null,
    c_customer_email VARCHAR(20) not null,
    c_customer_city VARCHAR(20) not null,
    c_customer_zip INT not null,
    c_customer_country CHAR(2) not null,
    CONSTRAINT pk_c_customer_id primary key(c_customer_id),
    CONSTRAINT u_c_customer_id UNIQUE(c_customer_id)
)
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='suppliers')
DROP TABLE suppliers
GO
create TABLE suppliers
(
    s_supplier_number int IDENTITY(1,1)  not NULL,
    s_supplier_name VARCHAR(20) not NULL,
    s_supplier_id int not null,
    s_supplier_country CHAR(2) not null,
    CONSTRAINT pk_s_supplier_number primary key (s_supplier_number),
    CONSTRAINT u_s_supplier_id UNIQUE(s_supplier_id),
    CONSTRAINT u_s_supplier_name unique(s_supplier_name)
)
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='products')
DROP TABLE products
GO

create table products 
(
    p_product_id int not null,
    p_product_name varchar(50) not null,
    p_product_line varchar(20) not null,
    p_product_category VARCHAR(20) not null,
    p_supplier_id int not null,
    p_product_price money not null,
    CONSTRAINT pk_p_product_id primary key (p_product_id),
    constraint u_p_product_name UNIQUE(p_product_name),
)
alter table products
add CONSTRAINT fk_product_supplier_id FOREIGN key (p_supplier_id) REFERENCES suppliers(s_supplier_id)
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='employees')
DROP TABLE employees
GO

create table employees 
(
    e_employee_id int not null,
    e_employee_firstname varchar(20) not NULL,
    e_employee_lastname varchar(20) not NULL,
    e_employee_street varchar(20) not null,
    e_employee_city varchar(20) not null,
    e_employee_state CHAR(2) not null,
    e_employee_postalcode int not null,
    e_employee_salary INT not null,
    e_employee_country char(20) not null,
    CONSTRAINT pk_e_employee_id primary key(e_employee_id)
)
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='orders')
DROP TABLE orders
GO
create table orders
(
    o_order_id int not null,
    o_total_price money not NULL,
    o_cart_id int not null,
    o_cart_product_id int not NULL,
    o_product_name varchar(50) not null,
    o_supplier_id INT not null,
    o_customer_id int not null,
    o_customer_firstname VARCHAR(20) not null,
    o_customer_lastname varchar(20) not null,
    constraint pk_o_order_id primary  key (o_order_id),
    CONSTRAINT u_o_order_id UNIQUE(o_order_id)
)
alter table orders 
Add 
--constraint fk_o_order_cart_id FOREIGN key(o_cart_id)  REFERENCES carts(ct_cart_id), 
CONSTRAINT fk_o_order_product_id FOREIGN KEY(o_cart_product_id) REFERENCES products(p_product_id),
CONSTRAINT fk_o_supplier_id FOREIGN key(o_supplier_id) references suppliers(s_supplier_id)
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='carts')
DROP TABLE carts
GO

create table carts 
(
    ct_cart_number int IDENTITY not null,
    ct_cart_id int not null,
    ct_cart_items_purchased VARCHAR(4) not null,
    ct_quantity_wished int not null,
    ct_customer_firstname varchar(20) not null,
    ct_customer_lastname VARCHAR(20) not null,
    ct_customer_id int not null,
    ct_product_id INT not null,
    ct_product_name VARCHAR(100) not null,
    CONSTRAINT pk_ct_cart_id primary KEY(ct_cart_number),
    CONSTRAINT u_ct_cart_id UNIQUE (ct_cart_id)
)
alter table carts 
add 
    constraint fk_ct_cart_customer_id FOREIGN key (ct_customer_id) REFERENCES customers(c_customer_id),
    constraint fk_ct_cart_product_id FOREIGN key (ct_product_id) REFERENCES products(p_product_id)
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='payments')
DROP TABLE payments
GO

create table payments
(
    py_payment_number int IDENTITY not null,
    py_payment_id int not null,
    py_payment_date date not null,
    py_payment_type char(10) not null,
    py_payment_amount FLOAT not null,
    py_payment_order_id int not null,
    py_payment_employee_id int not null,
    py_payment_customer_id int not null,
    py_payment_customer_firstname VARCHAR(20) not null,
    py_payment_customer_lastname VARCHAR(20) not null,
    CONSTRAINT pk_py_payment_number primary key(py_payment_number),
    CONSTRAINT u_py_payment_id UNIQUE(py_payment_id)
)
alter table payments
add 
    constraint fk_py_payments_employee_id FOREIGN key (py_payment_employee_id) REFERENCES employees(e_employee_id),
    constraint fk_py_payments_order_id FOREIGN key (py_payment_order_id) REFERENCES orders(o_order_id)
GO

insert into customers
VALUES 
    (1,'Sushil','Deshmukh','100 Euclid Ave','Euclid Ave','sdeshmuk@syr.edu','Syracuse',13244,'US'),
    (2,'Ameya','Kelaskar','110 Lancaster Ave','Lancaster Ave','akelaska@syr.edu','Syracuse',13245,'US'),
    (3,'Michael','Fudge','130 Comstock ave','Comstock Ave','mafudge@syr.edu','Rochester',13233,'US'),
    (4,'Bob','Vaugh','200 Vinod ave','Vinod ave','bobvgh@gmail.com','Dusseldorf',11290,'EU'),
    (5,'Jenna','Johnson','300 XPR Street','XPR Street','jjohnson@gmail.com','Dusseldorf',12003,'EU');
GO
INSERT into suppliers
VALUES
    ('Puma',100,'US'),
    ('Adidas',101,'EU'),
    ('Nike',102,'US'),
    ('Under Armour',103,'IN'),
    ('Asics',104,'IN');
GO
Insert into employees
VALUES
    (1,'Kunal','Shah','Van Bueren Street','Syracuse','NY',13210,50000,'US'),
    (2,'Michael','Fudge Jr','E. Gennesse street','Rochester','NY',13244,150000,'EU'),
    (3,'John','Adams','redmond st.','Palo Alto','CA',14738,30000,'US'),
    (4,'Johnny','Depp','E. colvin','Rochester','NY',12343,100000,'US'),
    (5,'Nithin','Kamath','Redfield Pl','Syracuse','NY',13211,90000,'US');
GO
insert into products
VALUES
    (1001,'Puma RS-X Sports Shoes','Sports Shoes','MEN',100,110),
    (1002,'Adidas Badminton Raquet','Equipment','ALL',101,200),
    (1003,'Nike Air Jordan Shoes','Sports Shoes','MEN',102,500),
    (1004,'Nike Magic Johnson Shoes','Sports Shoes','MEN',102,600),
    (1005,'Adidas Sweatshirt','Apparel','KIDS',101,60),
    (1006,'Under Armour Duffel Bag','Bags','ALL',103,150),
    (1007,'Under Armour Trackpants','Apparel','MEN',103,40),
    (1008,'Asics Basic Sports Shoes','Sports Shoes','KIDS',104,200),
    (1009,'Asics PRO Sports Shoes','Sports Shoes','MEN',104,350),
    (1010,'Puma Running Shorts','Apparel','WOMEN',100,230);
GO
Insert into orders
VALUES
    (0001,440,1,1001,'Puma RS-X Sports Shoes',100,1,'Sushil','Deshmukh'),
    (0002,400,1,1002,'Adidas Badminton Raquet',101,1,'Sushil','Deshmukh'),
    (0003,690,2,1010,'Puma Running Shorts',100,2,'Ameya','Kelaskar'),
    (0004,200,5,1008,'Asics Basic Sports Shoes',104,3,'Michael','Fudge'),
    (0005,2400,3,1004,'Nike Magic Johnson Shoes',102,3,'Michael','Fudge'),
    (0006,80,4,1007,'Under Armour Trackpants',103,5,'Jenna','Johnson'),
    (0007,60,6,1005,'Adidas Sweatshirt',101,5,'Jenna','Johnson')
GO
INSERT into carts
VALUES
    (1,'Yes',2,'Sushil','Deshmukh',1,1001,'Puma RS-X Sports Shoes,Adidas Badminton Raquet'),
    (2,'No',3,'Ameya','Kelaskar',2,'1010','Puma Running Shorts'),
    (3,'No',4,'Michael','Fudge',3,'1004',',Nike Magic Johnson Shoes'),
    (4,'Yes',2,'Jenna','Johnson',5,'1007','Under Armour Trackpants'),
    (5,'Yes',2,'Michael','Fudge',3,'1008','Asics Basic Sports Shoes'),
    (6,'No',1,'Jenna','Johnson',5,'1005','Adidas Sweatshirt');
GO
Insert into payments
VALUES
    (1,'2021-04-21','Card',840,0001,2,1,'Sushil','Deshmukh'),
    (2,'2020-03-11','Cash',200,0002,3,2,'Ameya','Kelaskar'),
    (3,'2020-12-12','Card',350,0004,2,5,'Jenna','Johnson'),
    (4,'2019-03-28','Cash',500,0005,2,3,'Michael','Fudge'),
    (5,'2019-05-15','Card',60,0007,3,1,'Sushil','Deshmukh');
GO
select * from orders
select * from products
select * from payments
select * from customers
select * from employees
select * from suppliers
select * from carts
GO
if exists(SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='customer_and_payment')
drop view customer_and_payment
GO
create view customer_and_payment as 
select cs.c_customer_firstname+' '+cs.c_customer_lastname as 'Customer Name',c.ct_cart_items_purchased as 'Payment Processed' from carts as c join customers as cs on c.ct_customer_id=cs.c_customer_id 
GO

if exists (select * from INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='employee_and_payment')
drop view employee_and_payment
GO
create view employee_and_payment as
select e.e_employee_firstname+' '+e.e_employee_lastname as 'Payemnt processed by Employee',p.py_payment_amount as 'Amount',p.py_payment_type as 'Mode',c.c_customer_firstname+' '+c.c_customer_lastname as 'Customer Name'  from payments as p join employees as e on p.py_payment_employee_id=e.e_employee_id
join customers as c on p.py_payment_customer_id=c.c_customer_id 




--select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS