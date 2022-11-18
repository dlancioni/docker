/*
David lancioni - 11/23
Generate random number
call sp_fake(1000)
SELECT * from tb_person
*/
USE entity;
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
    DECLARE person_id INT DEFAULT 0;
    
    SET FOREIGN_KEY_CHECKS = 0;
    
	TRUNCATE tb_person_document;
    TRUNCATE tb_address;
	TRUNCATE tb_person;

    WHILE i <= number_of_clients DO

		INSERT INTO tb_person (category_id, type_id, name, birth) VALUES (fn_random_int(1, 4), fn_random_int(1, 3), CONCAT('Name ', i), fn_random_date(100, 200));
        SET person_id = LAST_INSERT_ID();
 
        SET j = 1;
        SET count = fn_random_INT(1, 4);
        WHILE j <= count do
            INSERT INTO tb_address (person_id, address_type_id, street, number, complement, city, state_id) VALUES ( person_id, fn_random_INT(1, 3) , CONCAT('Street ', j), fn_random_INT(100, 100), CONCAT('Complement ', j), CONCAT('City ', j), fn_random_INT(1, 5));
            SET j = j + 1;
        END WHILE;

        SET j = 1;
        SET count = 4;
        WHILE j <= count do
            INSERT INTO tb_person_document (person_id, document_id, number ) VALUES (person_id, fn_random_INT(1, 5) , fn_random_INT(100000000, 200000000));
            SET j = j + 1;
        END WHILE;        

        SET i = i + 1;

    END WHILE;

    COMMIT;
    
    SET FOREIGN_KEY_CHECKS = 1;
END$$
DELIMITER ;