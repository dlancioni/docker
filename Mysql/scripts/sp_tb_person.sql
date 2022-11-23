/*
delete from tb_person;
select * from tb_person;
call sp_tb_person('I', null, 1, 1, 'Name 2', '2022-12-31', @sid, @msg);
call sp_tb_person('U', 8, 1, 1, 'Name 1', '2022-02-15', @sid, @msg);
call sp_tb_person('D', 9, null, null, null, null, @sid, @msg);
call sp_tb_person('S', 10, null, null, null, null, @sid, @msg);
call sp_tb_person('S', null, null, null, null, null, @sid, @msg);
*/

USE person;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_tb_person;
CREATE PROCEDURE sp_tb_person
(
	IN p_action char(1),
	IN p_id int,
	IN p_classification_id INT,
	IN p_type_id INT,
    IN p_name VARCHAR(50),
	IN p_birth DATE,
    OUT sid INT,
    OUT msg VARCHAR(500)
)
LANGUAGE SQL
DETERMINISTIC
SQL SECURITY DEFINER
COMMENT 'Manage order and order items'
BEGIN

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

		IF p_id is null THEN
			SELECT * FROM tb_person;
        ELSE
			SELECT * FROM tb_person WHERE id = p_id;
  		END IF;

    END IF;

	SET sid = 1;
	SET msg = 'Processado com sucesso !!!';

END
$$