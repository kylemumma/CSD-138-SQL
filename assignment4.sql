/* Kyle Mumma */
USE my_guitar_shop; 

/*
QUESTION 1
*/
SELECT DISTINCT category_name
FROM   categories
WHERE  category_id IN (SELECT category_id
                       FROM   products)
ORDER BY category_name; 

/*
QUESTION 2
*/
SELECT product_name,
       list_price
FROM   products
WHERE  list_price > (SELECT Avg(list_price)
                     FROM   products); 

/*
QUESTION 3
*/
SELECT DISTINCT category_id,
                category_name
FROM   categories
WHERE  NOT EXISTS (SELECT DISTINCT category_id
                   FROM   products
                   WHERE  category_id = categories.category_id); 

/*
QUESTION 4
*/
SELECT product_name,
       discount_percent
FROM   products
WHERE  discount_percent NOT IN (SELECT discount_percent
                                FROM   products
                                HAVING Count(*) > 1)
ORDER BY product_name; 

/*
QUESTION 5
*/
SELECT email_address,
       order_id,
       order_date
FROM   customers c
       JOIN orders o
         ON c.customer_id = o.customer_id
WHERE  order_date = (SELECT Min(order_date)
                     FROM   orders
                     WHERE  customer_id = o.customer_id); 

/*
QUESTION 6
*/
CREATE VIEW customer_addresses 
AS 
  SELECT c.customer_id, 
         email_address, 
         last_name, 
         first_name, 
         bill.line1    AS bill_line1, 
         bill.line2    AS bill_line2, 
         bill.city     AS bill_city, 
         bill.state    AS bill_state, 
         bill.zip_code AS bill_zip, 
         ship.line1    AS ship_line1, 
         ship.line2    AS ship_line2, 
         ship.city     AS ship_city, 
         ship.state    AS ship_state, 
         ship.zip_code AS ship_zip 
  FROM   customers c 
         JOIN addresses bill 
           ON c.billing_address_id = bill.address_id 
         JOIN addresses ship 
           ON c.shipping_address_id = ship.address_id;

SELECT customer_id, 
       last_name, 
       first_name, 
       bill_line1 
FROM   customer_addresses;
