/* Kyle Mumma */
USE my_guitar_shop;

SELECT CONCAT(last_name, ', ', first_name) AS full_name
FROM customers
WHERE LEFT(last_name, 1) BETWEEN 'M' AND 'Z'
ORDER BY last_name;

SELECT product_name,
        list_price,
        date_added
FROM products
WHERE list_price BETWEEN 501 AND 1999
ORDER BY date_added DESC;

SELECT product_name,
        list_price,
        discount_percent,
        ROUND(list_price * (discount_percent / 100), 2) AS discount_amount,
        ROUND(list_price - (list_price * (discount_percent / 100)), 2) AS discount_price
FROM products
ORDER BY discount_price DESC
LIMIT 5;

SELECT item_id,
        item_price,
        discount_amount,
        quantity,
        item_price * quantity AS price_total,
        discount_amount * quantity AS discount_total,
        (item_price - discount_amount) * quantity AS item_total
FROM order_items
WHERE (item_price - discount_amount) * quantity > 500
ORDER BY item_total DESC;