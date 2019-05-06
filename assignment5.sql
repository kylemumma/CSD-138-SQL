/* Kyle Mumma */

/* QUESTION 1 */
INSERT INTO categories
VALUES (null, "Brass");

/* QUESTION 2 */
UPDATE categories
SET category_name = "Woodwinds"
WHERE category_id = 5;

/* QUESTION 3 */
DELETE FROM categories
WHERE category_id = 5;

/* QUESTION 4 */
INSERT INTO products (product_id,
                    category_id, 
                    product_code,
                    product_name,
                    description,
                    list_price,
                    discount_percent,
                    date_added)
VALUES (null,
        4,
        "dgx_640",
        "Yamaha DGX 640 88-Key Digital Piano",
        "Long description to come",
        799.99,
        0,
        NOW());

/* QUESTION 5 */
UPDATE products
SET discount_percent = 35
WHERE product_id = 11;

/* QUESTION 6 */
INSERT INTO customers (email_address,
                        password, 
                        first_name,
                        last_name)
VALUES ('rick@raven.com',
        '',
        'Rick',
        'Raven');

/* QUESTION 7 */
UPDATE customers
SET password = 'secret'
WHERE email_address = 'rick@raven.com';

/* QUESTION 8 */
UPDATE customers
SET password = 'reset';

/* QUESTION 10 */
CREATE DATABASE IF NOT EXISTS my_web_db;

USE my_web_db;

DROP TABLE IF EXISTS users;
CREATE TABLE users
(
    user_id INT NOT NULL AUTO_INCREMENT,
    email_address VARCHAR(100),
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS products;
CREATE TABLE products
(
    product_id INT AUTO_INCREMENT,
    product_name VARCHAR(45),
    PRIMARY KEY (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS downloads;
CREATE TABLE downloads
(
    download_id INT NOT NULL AUTO_INCREMENT,
    user_id INT ,
    download_date DATETIME,
    filename VARCHAR(50),
    product_id INT,
    PRIMARY KEY (download_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* QUESTION 11 */
INSERT INTO users (user_id, email_address, first_name, last_name)
VALUES (null, 'user1@test.com', 'user1', 'test');

INSERT INTO users (user_id, email_address, first_name, last_name)
VALUES (null, 'user2@test.com', 'user2', 'test');

INSERT INTO products (product_id, product_name)
VALUES (null, 'product1');

INSERT INTO products (product_id, product_name)
VALUES (null, 'product2');

INSERT INTO downloads (download_id, 
                        user_id, 
                        product_id, 
                        filename, 
                        download_date)
VALUES (null, 1, 2, 'download1', NOW());

INSERT INTO downloads (download_id, 
                        user_id, 
                        product_id, 
                        filename, 
                        download_date)
VALUES (null, 2, 1, 'download2', NOW());

INSERT INTO downloads (download_id, 
                        user_id, 
                        product_id, 
                        filename, 
                        download_date)
VALUES (null, 2, 2, 'download3', NOW());

/* QUESTION 12 */
SELECT product_name, first_name, last_name
FROM products p
    JOIN downloads d
    JOIN users u
ON p.product_id = d.product_id AND
    u.user_id = d.user_id
ORDER BY product_name, last_name, first_name;

/* QUESTION 13 */
ALTER TABLE products
ADD product_price DECIMAL(5, 2) DEFAULT 9.99;

ALTER TABLE products
ADD date_added DATETIME;

/* QUESTION 14 */
ALTER TABLE users
MODIFY COLUMN first_name VARCHAR(20) NOT NULL;

UPDATE users
SET first_name = null
WHERE user_id = 1;

UPDATE users
SET first_name = 'this is a very long name'
WHERE user_id = 1;