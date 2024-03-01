create database E_commerce;
use E_commerce;

create table supplier (SUPP_ID int primary key, SUPP_NAME varchar(50) not null, 
SUPP_CITY varchar(50) not null,
SUPP_PHONE varchar(50) not null);

create table customer (CUS_ID int primary key, CUS_NAME varchar(20) not null, 
CUS_PHONE varchar(10) not null,
CUS_CITY varchar(30) not null, CUS_GENDER char);

create table category (CAT_ID int primary key, CAT_NAME varchar(20) not null);

create table product (PRO_ID int primary key, PRO_NAME varchar(20) not null default "dummy",
PRO_DESC VARCHAR(60), CAT_ID int, foreign key (CAT_ID) references category(CAT_ID));

create table supplier_pricing (PRICING_ID INT PRIMARY KEY,
PRO_ID INT, FOREIGN KEY(PRO_ID) REFERENCES product(PRO_ID),
SUPP_ID INT, FOREIGN KEY(SUPP_ID) REFERENCES supplier(SUPP_ID),
SUPP_PRICE INT DEFAULT 0);

create table orders(ORD_ID INT PRIMARY KEY,
ORD_AMOUNT INT NOT NULL, ORD_DATE DATE NOT NULL,
CUS_ID INT, FOREIGN KEY(CUS_ID) REFERENCES customer(CUS_ID),
PRICING_ID INT, FOREIGN KEY(PRICING_ID) REFERENCES supplier_pricing(PRICING_ID));

create table rating (RAT_ID INT PRIMARY KEY,
ORD_ID INT, FOREIGN KEY(ORD_ID) REFERENCES orders(ORD_ID),
RAT_RATSTARS INT NOT NULL);

insert into supplier values (1, 'Rajesh Retails', 'Delhi', '1234567890'),
(2, 'Appario Ltd.', 'Mumbai', '2589631470'),
(3, 'Knome products', 'Banglore', '9785462315'),
(4, 'Bansal Retails', 'Kochi', '8975463285'),
(5, 'Mittal Ltd.', 'Lucknow', '7898456532');

insert into customer values (1, 'AAKASH', '9999999999', 'DELHI', 'M'),
(2, 'AMAN', '9785463215', 'NOIDA', 'M'),
(3, 'NEHA', '9999999999', 'MUMBAI', 'F'),
(4, 'MEGHA', '9994562399', 'KOLKATA', 'F'),
(5, 'PULKIT', '7895999999', 'LUCKNOW', 'M');

insert into category values (1, 'BOOKS'),
(2, 'GAMES'),
(3, 'GROCERIES'),
(4, 'ELECTRONICS'),
(5, 'CLOTHES');

insert into product values (1, 'GTA V', 'Windows 7 and above with i5 processor and 8GB RAM', 2),
(2, 'TSHIRT', 'SIZE-L with Black, Blue and White variations', 5),
(3, 'ROG LAPTOP', 'Windows 10 with 15inch screen, i7 processor, 1TB SSD', 4),
(4, 'OATS', 'Highly Nutritious from Nestle', 3),
(5, 'HARRY POTTER', 'Best Collection of all time by J.K Rowling', 1),
(6, 'MILK', '1L Toned MIlk', 3),
(7, 'Boat Earphones', '1.5Meter long Dolby Atmos', 4),
(8, 'Jeans', 'Stretchable Denim Jeans with various sizes and color', 5),
(9, 'Project IGI', 'compatible with windows 7 and above', 2),
(10, 'Hoodie', 'Black GUCCI for 13 yrs and above', 5),
(11, 'Rich Dad Poor Dad', 'Written by Robert Kiyosaki', 1),
(12, 'Train Your Brain', 'By Shireen Stephen', 1);

insert into supplier_pricing values(1, 1, 2, 1500),
(2, 3, 5, 30000),
(3, 5, 1, 3000),
(4, 2, 3, 2500),
(5, 4, 1, 1000),
(6, 12, 2, 780),
(7, 12, 4, 789),
(8, 3, 1, 31000),
(9, 1, 5, 1450),
(10, 4, 2, 999),
(11, 7, 3, 549),
(12, 7, 4, 529),
(13, 6, 2, 105),
(14, 6, 1, 99),
(15, 2, 5, 2999),
(16, 5, 2, 2999);

insert into orders values(101, 1500, '2021-10-06', 2, 1),
(102, 1000, '2021-10-12', 3, 5),
(103, 30000, '2021-09-16', 5, 2),
(104, 1500, '2021-10-05', 1, 1),
(105, 3000, '2021-08-16', 4, 3),
(106, 1450, '2021-08-18', 1, 9),
(107, 789, '2021-09-01', 3, 7),
(108, 780, '2021-09-07', 5, 6),
(109, 3000, '2021-01-10', 5, 3),
(110, 2500, '2021-09-10', 2, 4),
(111, 1000, '2021-09-15', 4, 5),
(112, 789, '2021-09-16', 4, 7),
(113, 31000, '2021-09-16', 1, 8),
(114, 1000, '2021-09-16', 3, 5),
(115, 3000, '2021-09-16', 5, 3),
(116, 99, '2021-09-17', 2, 14);

insert into rating values(1, 101, 4),
(2, 102, 3),
(3, 103, 1),
(4, 104, 2),
(5, 105, 4),
(6, 106, 3),
(7, 107, 4),
(8, 108, 4),
(9, 109, 3),
(10, 110, 5),
(11, 111, 3),
(12, 112, 4),
(13, 113, 2),
(14, 114, 1),
(15, 115, 1),
(16, 116, 0);

/*QUESTION 4 QUERY*/
select count(c.CUS_NAME) as number_of_customers, c.CUS_GENDER as gender
from customer as c
inner join orders as o
on c.CUS_ID=o.CUS_ID
where o.ORD_AMOUNT >= 3000
group by c.CUS_GENDER;

/*QUESTION 5 QUERY*/ 
select o.ORD_ID as Order_ID, p.PRO_NAME as Product_name
from customer as c
inner join  orders as o on c.CUS_ID=o.CUS_ID
inner join supplier_pricing as sp on o.PRICING_ID=sp.PRICING_ID
inner join product as p on p.PRO_ID=sp.PRO_ID
where c.CUS_ID = 2;

/*QUESTION 6 QUERY*/
select s.SUPP_ID as ID, s.SUPP_NAME as name, s.SUPP_CITY as City, s.SUPP_PHONE as Phone, count(p.PRO_ID) as products
from supplier s
inner join supplier_pricing as sp on s.SUPP_ID=sp.SUPP_ID
inner join product as p on sp.PRO_ID=p.PRO_ID
where p.PRO_ID >1
group by s.SUPP_ID, s.SUPP_NAME, s.SUPP_CITY, s.SUPP_PHONE;

/*QUESTION 7 QUERY*/
select c.CAT_ID as category_ID, c.CAT_NAME as category_name, p.PRO_NAME as product_name, SUPP_PRICE as Price
from category as c
inner join product as p on c.CAT_ID=p.CAT_ID
inner join supplier_pricing as sp on p.PRO_ID=sp.PRO_ID
where (p.CAT_ID, sp.SUPP_PRICE) IN (SELECT p.CAT_ID, MIN(sp.SUPP_PRICE) AS min_price
FROM product AS p
INNER JOIN supplier_pricing AS sp ON p.PRO_ID = sp.PRO_ID
GROUP BY p.CAT_ID);

/*QUESTION 8 QUERY*/
select p.PRO_ID as product_ID, p.PRO_NAME as product_Name
from product as p
inner join supplier_pricing as sp on p.PRO_ID=sp.PRO_ID
inner join  orders as o on sp.PRICING_ID=o.PRICING_ID
where o.ORD_DATE > '2021-10-05';

/*QUESTION 9 QUERY*/
select CUS_NAME as customer_name, CUS_GENDER as gender
from customer where CUS_NAME like '%A' or CUS_NAME like 'A%';

/*QUESTION 10 QUERY*/
DELIMITER $$
create procedure Supplier_Rating()
BEGIN
select s.SUPP_ID as supplier_id, s.SUPP_NAME as supplier_name, avg(r.RAT_RATSTARS) as rating,
case WHEN AVG(r.RAT_RATSTARS) = 5 THEN 'Excellent Service'
	WHEN AVG(r.RAT_RATSTARS) > 4 THEN 'Good Service'
	WHEN AVG(r.RAT_RATSTARS) > 2 THEN 'Average Service'
	ELSE 'Poor Service'
   END as Type_of_Service
from supplier as s
inner join supplier_pricing as sp on s.SUPP_ID=sp.SUPP_ID
inner join orders as o on sp.PRICING_ID=o.PRICING_ID
inner join rating as r on o.ORD_ID=r.ORD_ID
group by s.SUPP_ID, s.SUPP_NAME;
END $$
DELIMITER ;

call Supplier_Rating();
