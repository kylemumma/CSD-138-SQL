/* Kyle Mumma */

/* Question 1 */
DELIMITER //

DROP PROCEDURE IF EXISTS test//
CREATE PROCEDURE test()
BEGIN
    DECLARE x INT;
    SET x = (
        SELECT Count(*)
        FROM products
    );
    IF x >= 7 THEN 
    	SELECT 'The number of products is greater than or equal to 7';
    ELSE 
    	SELECT 'The number of products is less than 7';
    END IF;
END//

CALL test()//

/* QUESTION 2 */
DELIMITER //

DROP PROCEDURE IF EXISTS test//
CREATE PROCEDURE test()
BEGIN
    DECLARE product_count INT;
    DECLARE avg_price DECIMAL(4, 3);
    SET product_count = (
        SELECT Count(*)
        FROM products
    );
    SET avg_price = (
        SELECT Avg(list_price)
        FROM products
    );
    
    IF product_count >= 7 THEN
        SELECT product_count, avg_price;
    ELSE
        SELECT 'The number of products is less than 7';
    END IF;
END//

CALL test()//

/* Question 3 */

DELIMITER //

DROP PROCEDURE IF EXISTS test//
CREATE PROCEDURE test()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE common_factors VARCHAR(100) DEFAULT 'Common factors of 10 and 20: ';

    WHILE i <= 10 DO 
        IF(10%i = 0 AND 20%i = 0) THEN
            SET common_factors = Concat(common_factors, i, ' ');
        END IF;
        SET i = i + 1;
    END WHILE;

    SELECT common_factors;
END//

CALL test()//

/* Question 4 */
DELIMITER //

DROP PROCEDURE IF EXISTS test//
CREATE PROCEDURE test()
BEGIN
    DECLARE row_not_found TINYINT DEFAULT 0;
    DECLARE product_list VARCHAR(400) DEFAULT '';
    DECLARE name_var VARCHAR(100);
    DECLARE price_var VARCHAR(25);

    DECLARE price_cursor CURSOR FOR
        SELECT product_name, list_price
        FROM products
        WHERE list_price > 700
        ORDER BY list_price DESC;

    DECLARE CONTINUE HANDLER FOR NOT FOUND 
        SET row_not_found = 1;

    OPEN price_cursor;
        WHILE row_not_found = 0 DO 
            FETCH NEXT FROM price_cursor INTO name_var, price_var;
            SET product_list = Concat(product_list, '"', name_var, '", "', price_var, '" | "');
        END WHILE;
    CLOSE price_cursor;

    SELECT product_list;
END//

CALL test()//

/* Question 5 */
DELIMITER //

DROP PROCEDURE IF EXISTS test//
CREATE PROCEDURE test()
BEGIN
    DECLARE error_status TINYINT DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR 1062
        SET error_status = TRUE;

    INSERT INTO categories
    VALUES (null, 'Guitars');

    IF error_status = FALSE THEN
        SELECT '1 row was inserted.';
    ELSE
        SELECT 'Row was not inserted - duplicate entry.';
    END IF;
END//

CALL test()//

/* Question 6 */
DELIMITER //
DROP PROCEDURE IF EXISTS insert_category//
CREATE PROCEDURE insert_category(IN category_name VARCHAR(50))
BEGIN
    INSERT INTO categories
    VALUES (null, category_name);
END//

CALL insert_category('Violins')//
CALL insert_category('Trumpets')//

/* Question 7 */
DELIMITER //
DROP FUNCTION IF EXISTS discount_price//
CREATE FUNCTION discount_price(item_id INT) RETURNS DECIMAL(6, 2)
BEGIN
    DECLARE discounted_price_var DECIMAL(6, 2) DEFAULT 0;

    SELECT item_price - discount_amount
    INTO discounted_price_var
    FROM order_items oi
    WHERE oi.item_id = item_id;

    RETURN discounted_price_var;
END//

/* Question 8 */
DELIMITER //
DROP FUNCTION IF EXISTS item_total//
CREATE FUNCTION item_total(item_id INT) RETURNS DECIMAL(6, 2)
BEGIN
    DECLARE item_total_cost DECIMAL(6, 2) DEFAULT 0;

    SELECT discount_price(item_id) * quantity
    INTO item_total_cost
    FROM order_items oi
    WHERE oi.item_id = item_id;

    RETURN item_total_cost;
END//

/* Question 9 */
DELIMITER //
DROP PROCEDURE IF EXISTS update_product_discount//
CREATE PROCEDURE update_product_discount(IN product_id INT, IN discount_percent DECIMAL(5, 2))
BEGIN
    IF discount_percent < 0 THEN
        SIGNAL SQLSTATE '22003'
            SET MESSAGE_TEXT = 'The value for the discount_percent column must be greater than or equal to 0',
            MYSQL_ERRNO = 1264;
    END IF;

    UPDATE products p
    SET p.discount_percent = discount_percent
    WHERE p.product_id = product_id;
END//

CALL update_product_discount(1, 50)//
CALL update_product_discount(2, 0)//

/* Question 10 */
DELIMITER //
DROP PROCEDURE IF EXISTS test//
CREATE PROCEDURE test()
BEGIN
    DECLARE sql_error TINYINT DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SET sql_error = TRUE;
    
    START TRANSACTION;

    DELETE FROM addresses
    WHERE customer_id = 8;

    DELETE FROM customers
    WHERE customer_id = 8;

    IF sql_error = FALSE THEN
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END//