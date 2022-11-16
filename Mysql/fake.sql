/*
David lancioni - 11/23
Generate random number
call sp_fake(10)
SELECT * from tb_entity
*/
USE ecommerce;
DROP FUNCTION IF EXISTS fn_random_int;
DROP FUNCTION IF EXISTS fn_random_date;
DROP PROCEDURE if exists sp_fake;
DELIMITER $$

CREATE FUNCTION fn_random_INT (minimum INT, maximum INT)
RETURNS INT
DETERMINISTIC
begin
    DECLARE random_INT INT DEFAULT 1;
    SELECT floor( rand() * ( maximum - minimum ) + minimum ) INTO random_int;
    RETURN random_int;
END$$

CREATE FUNCTION fn_random_date (minimum INT, maximum INT)
RETURNS DATE
DETERMINISTIC
begin
	DECLARE random_int INT DEFAULT 1;
    DECLARE random_date date DEFAULT curdate();
    SELECT floor( rand() * ( maximum - minimum ) + minimum ) INTO random_int;
    SELECT date_sub(curdate(), INTERVAL random_INT MONTH) INTO random_date;
    RETURN random_date;
END$$

CREATE PROCEDURE sp_fake(IN number_of_clients INT)
begin

    DECLARE count INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 1;
    DECLARE entity_id INT DEFAULT 0;

	DELETE FROM tb_entity_document;
	DELETE FROM tb_entity_login;
    DELETE FROM tb_address;
	DELETE FROM tb_entity;

    WHILE i <= number_of_clients DO

		INSERT INTO tb_entity ( ENTITY_TYPE_ID, NAME, BIRTH ) VALUES ( fn_random_int(1, 3) , CONCAT('Name ', i), fn_random_date(100, 200) );
        SET entity_id = LAST_INSERT_ID();

        INSERT INTO tb_entity_login ( ENTITY_ID, USERNAME, PASSWORD ) VALUES ( entity_id, CONCAT('username', entity_id), CONCAT('password', entity_id) );
 
        SET j = 1;
        SET count = fn_random_INT(1, 4);
        WHILE j <= count do
            INSERT INTO tb_entity_address ( ENTITY_ID, ADDRESS_TYPE_ID, STREET, NUMBER, COMPLEMENT, CITY, STATE ) VALUES ( entity_id, fn_random_INT(1, 3) , CONCAT('Street ', j), fn_random_INT(100, 100), CONCAT('Complement ', j), CONCAT('City ', j), 'SP' );
            SET j = j + 1;
        END WHILE;

        SET j = 1;
        SET count = 4;
        WHILE j <= count do
            INSERT INTO tb_entity_document ( ENTITY_ID, DOCUMENT_ID, NUMBER ) VALUES ( entity_id, fn_random_INT(1, 5) , fn_random_INT(100000000, 200000000) );
            SET j = j + 1;
        END WHILE;        

        SET i = i + 1;

    END WHILE;

    COMMIT;

END$$
DELIMITER ;