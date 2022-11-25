/*
delete from tb_person;
select * from tb_person;
call sp_tb_person('I', null, 1, 1, 'Name 2', '2022-12-31', @sid, @msg);
call sp_tb_person('U', 1, 1, 1, 'Name 1', '2021-01-01', @sid, @msg);
call sp_tb_person('D', 2, null, null, null, null, @sid, @msg);
call sp_tb_person('S', 1, null, null, null, null, @sid, @msg);
call sp_tb_person('S', null, null, null, null, null, @sid, @msg);

call sp_tb_person('I', null, 9, 1, 'Name 2', '2022-12-31', @sid, @msg);
select @sid, @msg

*/
USE ecommerce;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_tb_person;
CREATE PROCEDURE sp_tb_person
(
	IN p_action char(1),
	IN p_id int,
	IN p_type_id INT,
	IN p_classification_id INT,
    IN p_name VARCHAR(50),
	IN p_birth DATE,
    OUT sid INT,
    OUT msg VARCHAR(500)
)
LANGUAGE SQL
DETERMINISTIC
SQL SECURITY DEFINER
COMMENT 'Manage order and order items'
sp: BEGIN

	SET sid = 0;
	SET msg = '';
    
	IF p_action NOT IN ('I', 'U', 'D', 'S') THEN
        SELECT fn_get_message(1, '', '', '') INTO msg;
		LEAVE sp;
    END IF;

	IF p_action = 'U' OR p_action = 'D' THEN
		IF p_id IS NULL OR p_id = 0 THEN
			SELECT fn_get_message(2, 'tb_person', 'id', '', '') INTO msg;
			LEAVE sp;
		END IF;
    END IF;
    
	IF p_action = 'I' OR p_action = 'U' THEN
    
		-- Mandatory
		IF p_type_id IS NULL OR p_type_id = 0 THEN
			SELECT fn_get_message(2, 'tb_person', 'type_id', '', '') INTO msg;
			LEAVE sp;
		END IF;

		-- Field size
		IF length(p_name) > 50 THEN
			SELECT fn_get_message(4, 'tb_person', 'name', '', '') INTO msg;
			LEAVE sp;
		END IF;
       
		-- Foreign keys		
		SELECT id FROM tb_person_type WHERE id = p_type_id;
        IF FOUND_ROWS() = 0 THEN
			SELECT fn_get_message(3, 'tb_person', 'type_id', 'tb_person_type', 'id') INTO msg;
			LEAVE sp;
        END IF;		

	END IF;    

    IF p_action = "I" THEN

		INSERT INTO tb_person
		(
			classification_id,
			type_id,
			name,
			birth
		) VALUES (
			p_classification_id,
			p_type_id,
			p_name,
			p_birth
		);       

    ELSEIF p_action = "U" THEN

		UPDATE tb_person SET
			classification_id = p_classification_id,
			type_id = p_type_id,
			name = p_name,
			birth = p_birth
		WHERE id = p_id;
        
    ELSEIF p_action = "D" THEN

		DELETE FROM tb_person WHERE id = p_id;

    ELSEIF p_action = "S" THEN

		IF p_id is NULL THEN
			SELECT * FROM tb_person;
        ELSE
			SELECT * FROM tb_person WHERE id = p_id;
  		END IF;

    END IF;

	SET sid = 1;
	SET msg = 'Processado com sucesso !!!';
END
$$