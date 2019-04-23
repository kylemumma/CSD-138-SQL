/* Kyle Mumma */
USE my_guitar_shop;

/*
Question 1
*/
SELECT
   count(*),
   sum(tax_amount) 
FROM
   orders;

/*
Question 2
*/
SELECT
   category_name,
   count(*),
   max(list_price) 
FROM
   products 
   JOIN
      categories USING(category_id) 
GROUP BY
   category_name 
ORDER BY
   max(list_price) DESC;

/*
Question 3
*/
SELECT
   email_address,
   sum(item_price) * quantity AS item_price_total,
   sum(discount_amount) * quantity AS discount_amount_total 
FROM
   customers c 
   JOIN
      orders o 
   JOIN
      order_items oi 
      ON c.customer_id = o.customer_id 
      AND o.order_id = oi.order_id 
GROUP BY
   c.customer_id 
ORDER BY
   sum(item_price) * quantity DESC;

/*
Question 4
*/
SELECT
   email_address,
   count(*) AS amount_of_orders,
   sum((item_price - discount_amount) * quantity) AS total_spent 
FROM
   customers c 
   JOIN
      orders o 
   JOIN
      order_items oi 
      ON c.customer_id = o.customer_id 
      AND o.order_id = oi.order_id 
GROUP BY
   c.customer_id 
HAVING
   count(*) > 0 
ORDER BY
   total_spent;

/*
Question 5
*/
SELECT
   email_address,
   Count(*) AS amount_of_orders,
   Sum((item_price - discount_amount) * quantity) AS total_spent 
FROM
   customers c 
   JOIN
      orders o 
   JOIN
      order_items oi 
      ON c.customer_id = o.customer_id 
      AND o.order_id = oi.order_id 
WHERE
   item_price > 400 
GROUP BY
   c.customer_id 
HAVING
   count(*) > 0 
ORDER BY
   total_spent;

/*
Question 6
*/
SELECT
   product_name,
   Sum(( item_price - discount_amount ) * quantity) AS total_amount 
FROM
   products p 
   JOIN
      order_items oi 
      ON p.product_id = oi.product_id 
GROUP BY
   product_name WITH ROLLUP;

/*
Question 7
*/
SELECT
   email_address,
   Count(DISTINCT order_id) 
FROM
   customers c 
   JOIN
      orders o 
      ON c.customer_id = o.customer_id 
GROUP BY
   c.customer_id;