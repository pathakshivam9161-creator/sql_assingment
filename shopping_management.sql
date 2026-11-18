DROP DATABASE IF EXISTS Shopping_Management;
CREATE DATABASE Shopping_Management;
USE Shopping_Management;

-- 1. PARENT TABLE: customers
CREATE TABLE customers (
    Customer_Id INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone_Number CHAR(10) NOT NULL UNIQUE CHECK (Phone_Number REGEXP '^[0-9]{10}$'),
    Age INT CHECK (Age > 0),
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    Country VARCHAR(50) DEFAULT 'India',
    City VARCHAR(50) NOT NULL,
    Pincode CHAR(6) DEFAULT '201301',
    Registration_Date DATE DEFAULT (CURRENT_DATE),
    Registration_Time TIME DEFAULT (CURRENT_TIME),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Address VARCHAR(250),
    Customer_Status VARCHAR(15) DEFAULT 'Active' CHECK (Customer_Status IN ('Active', 'Inactive', 'Blocked')),
    Customer_Notes VARCHAR(500)
);

-- INSERT ORIGINAL CUSTOMERS
INSERT INTO customers (Customer_Name, Email, Phone_Number, Age, Gender, City, Address, Customer_Notes)
VALUES
    ('Aarav Mehta', 'aarav.mehta@example.com', '9811223344', 27, 'Male', 'Faridabad', 'Sector 16, Faridabad', 'Regular buyer'),
    ('Ananya Joshi', 'ananya.j@example.com', '9822334455', 24, 'Female', 'Gurugram', 'DLF Phase 3, Gurugram', 'Prefers evening delivery'),
    ('Rohan Nair', 'rohan.nair@example.com', '9833445566', 31, 'Male', 'Bengaluru', 'Indiranagar, Bengaluru', 'VIP member'),
    ('Sneha Kulkarni', 'sneha.k@example.com', '9844556677', 26, 'Female', 'Pune', 'Kothrud, Pune', NULL),
    ('Kabir Malhotra', 'kabir.m@example.com', '9855667788', 29, 'Male', 'Chandigarh', 'Sector 17, Chandigarh', 'Weekend orders');

-- 2. CHILD TABLE: orders
CREATE TABLE orders (
    Order_Id INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Id INT,
    Order_Date DATE DEFAULT (CURRENT_DATE),
    Order_Amount DECIMAL(10, 2) NOT NULL,
    Order_Status VARCHAR(20) DEFAULT 'Pending' CHECK (Order_Status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    Payment_Method VARCHAR(20) CHECK (Payment_Method IN ('Cash', 'Card', 'UPI', 'Net Banking')),
    Payment_Status VARCHAR(15) DEFAULT 'Pending' CHECK (Payment_Status IN ('Pending', 'Paid', 'Failed')),
    Shipping_Address VARCHAR(250) NOT NULL,
    Delivery_Pincode CHAR(6),
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Discount_Amount DECIMAL(10, 2) DEFAULT 0.00,
    Delivery_Date DATE NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Tracking_Number VARCHAR(30) UNIQUE,
    Delivery_Status VARCHAR(20) DEFAULT 'Not Dispatched' CHECK (Delivery_Status IN ('Not Dispatched', 'In Transit', 'Delivered', 'Returned')),
    Order_Notes VARCHAR(500),
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (Customer_Id)
        REFERENCES customers(Customer_Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- INSERT ORIGINAL ORDERS
INSERT INTO orders (Customer_Id, Order_Amount, Order_Status, Payment_Method, Payment_Status, Shipping_Address, Delivery_Pincode, Quantity, Discount_Amount, Tracking_Number, Delivery_Status)
VALUES
    (1, 1899.00, 'Shipped', 'UPI', 'Paid', 'Sector 16, Faridabad', '121002', 2, 100.00, 'SHP9001', 'In Transit'),
    (2, 3250.50, 'Delivered', 'Card', 'Paid', 'DLF Phase 3, Gurugram', '122002', 1, 250.00, 'SHP9002', 'Delivered'),
    (3, 4999.00, 'Processing', 'Net Banking', 'Paid', 'Indiranagar, Bengaluru', '560038', 3, 500.00, 'SHP9003', 'Not Dispatched'),
    (4, 850.00, 'Pending', 'Cash', 'Pending', 'Kothrud, Pune', '411038', 1, 0.00, 'SHP9004', 'Not Dispatched'),
    (5, 2400.00, 'Delivered', 'UPI', 'Paid', 'Sector 17, Chandigarh', '160017', 2, 150.00, 'SHP9005', 'Delivered');

-- VERIFY TABLES AND JOIN
SELECT * FROM customers;
SELECT * FROM orders;

SELECT 
    c.Customer_Id,
    c.Customer_Name,
    o.Order_Id,
    o.Order_Amount,
    o.Order_Status,
    o.Delivery_Status
FROM customers c
INNER JOIN orders o ON c.Customer_Id = o.Customer_Id;