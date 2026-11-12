Drop database if exists sample;
create database sample;
use sample;

create table customer(
      Id int primary key auto_increment,
      First_name varchar(50) not null, 
      Last_name varchar(50),
      phone varchar(10) not null,
      Age tinyint unsigned check (age>=18),
      Country varchar(100) default 'india',
      Email varchar (100) unique,
      Address tinytext,
      Pincode varchar (6) default '201301',
      Date_inserted_at DATE DEFAULT (CURRENT_DATE),
      created_time TIME DEFAULT (CURRENT_TIME),
      created_at_datetime TIMESTAMP DEFAULT (CURRENT_TIMESTAMP));
select * from customer;

INSERT INTO customer (First_name, Last_name, Phone, Age, Email, Address) -- we will not mention default column and
VALUES
('Amit', 'sharma', '9919214343', '22', 'amitsharma@gmail.com', 'A24 sector 3 noida'),
('sumit', 'sharma', '9954214343', '42', 'sumitsharma@gmail.com', 'A24 sector 3 delhi'),
('rajit', 'sharma', '9919564343', '52', 'rajitsharma@gmail.com', 'A24 sector 3 hardoi'),
('kartik', 'sharma', '9917814343', '32', 'kartiksharma@gmail.com', 'A24 sector 3 banguluru'),
('Asmmit', 'sharma', '9910984343', '42', 'asmmitsharma@gmail.com', 'A24 sector 3 deoria');


CREATE TABLE customer_order (
	Order_Id INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Id INT,
    Order_date DATE DEFAULT (CURRENT_DATE),
    Order_Amount DECIMAL (10,2) NOT NULL,
    Order_status ENUM('Pending' , 'shipped' , 'delivered', 'canclled ') DEFAULT 'pending',
    FOREIGN KEY (Customer_Id) REFERENCES customer(Id) ON DELETE CASCADE,
     FOREIGN KEY (Customer_Id) REFERENCES customer(Id) ON UPDATE CASCADE
     );
-- the ENUM data type in MySQL is used to define a column that can store only predefined values

INSERT INTO Customer_order (Customer_Id, Order_Amount, Order_status)
VALUES
(1, 1500.50, 'shipped'),
(2, 2000.30, 'shipped'),
(3, 405.67, 'canclled'),
(4, 353.43, 'delivered'),
(5, 756.54, 'delivered');

