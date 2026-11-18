USE customers_database;

SELECT*
FROM customers
WHERE state = 'Delhi'
AND points > 100;

SELECT first_name, last_name,monthly_income
FROM customers
WHERE monthly_income BETWEEN 50000 and 100000;

SELECT * 
FROM customers
WHERE first_name LIKE 'A%';

SELECT*
FROM customers
WHERE monthly_income = (
    SELECT MAX(monthly_income)
    FROM customers
    );
    
SELECT*
FROM custumers
WHERE phone IS NULL
OR phone = '';

SELECT*
FROM custumers
WHERE sector IS NOT NULL 
AND sector <> '';

SELECT DISTINCT state
FROM customers;

SELECT COUNT(DISTINCT city) AS
total_cities
FROM customers;

SELECT*
FROM customers
WHERE birth_date <'1990-01-01';

SELECT*
FROM customers
WHERE birth_date BETWEEN '1990-01-01'AND '2000-12-31';

SELECT first_name
FROM customers 
WHERE CHAR_LENGTH(first_name) = 5;

SELECT*
FROM customers
ORDER BY points DESC
LIMIT 5;

SELECT* 
FROM customers
WHERE first_name REGEXP '^[A-Za-z]{3,}$';

