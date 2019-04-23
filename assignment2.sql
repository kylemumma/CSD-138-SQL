/* Kyle Mumma */

USE my_guitar_shop;

SELECT category_name, product_name, list_price
FROM categories c INNER JOIN products p
ON c.category_id = p.category_id
ORDER BY category_name, product_name;

SELECT first_name, last_name, line1, city, state, zip_code
FROM customers c INNER JOIN addresses a
ON c.customer_id = a.customer_id
WHERE email_address = 'allan.sherwood@yahoo.com';

SELECT first_name, last_name, line1, city, state, zip_code
FROM customers c INNER JOIN addresses a 
ON c.customer_id = a.customer_id
WHERE shipping_address_id = address_id;

SELECT last_name, first_name, order_date, product_name,
        item_price, discount_amount, quantity
FROM customers c
    INNER JOIN orders o
    INNER JOIN order_items oi
    INNER JOIN products p 
ON c.customer_id = o.customer_id AND
    o.order_id = oi.order_id AND
    oi.product_id = p.product_id
ORDER BY last_name, order_date, product_name;

SELECT p1.product_name, p1.list_price
FROM products p1 JOIN products p2
WHERE p1.product_id != p2.product_id AND
        p1.list_price = p2.list_price
ORDER BY product_name;

SELECT category_name, product_id
FROM categories c LEFT JOIN products p
ON c.category_id = p.category_id
WHERE product_id IS NULL;

    SELECT 'SHIPPED' as ship_status, order_id, order_date
    FROM orders
    WHERE ship_date IS NOT NULL
UNION
    SELECT 'NOT SHIPPED' as ship_status, order_id, order_date
    FROM orders
    WHERE ship_date IS NULL
ORDER BY order_date;
