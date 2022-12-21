/*
select fn_get_message(1, '', '', '', '', '50');
select fn_get_message(2, 'tb_person', 'id', '', '', '');
select fn_get_message(3, 'tb_person', 'id', 'tb_person', 'id', '5');
select fn_get_message(4, 'tb_person', 'name', '', '', '50');
*/
USE ecommerce;

DELIMITER $$
DROP FUNCTION IF EXISTS fn_get_message;
CREATE FUNCTION fn_get_message
(
    p_id INT,
    p_1 VARCHAR(50),
    p_2 VARCHAR(50),
	p_3 VARCHAR(50),
    p_4 VARCHAR(50),
    p_5 VARCHAR(50)
)
RETURNS VARCHAR(500)
DETERMINISTIC
BEGIN
	DECLARE v_msg VARCHAR(500) DEFAULT '';

    DECLARE v_t1 VARCHAR(50) DEFAULT '';
    DECLARE v_f1 VARCHAR(50) DEFAULT '';
    DECLARE v_t2 VARCHAR(50) DEFAULT '';
    DECLARE v_f2 VARCHAR(50) DEFAULT '';

    SELECT message INTO v_msg FROM tb_message WHERE id = p_id;

    SELECT 
    table_label, 
    field_label 
    INTO v_t1, v_f1 
    FROM vw_table_field 
    WHERE table_name = p_1
    AND field_name = p_2;

    SELECT 
    table_label, 
    field_label 
    INTO v_t2, v_f2
    FROM vw_table_field 
    WHERE table_name = p_3
    AND field_name = p_4;

    IF p_id in (3, 4, 5) THEN
       SET v_msg = REPLACE(v_msg, '%1', v_f1);
	   SET v_msg = REPLACE(v_msg, '%2', v_t2);
	   SET v_msg = REPLACE(v_msg, '%3', p_5);
    ELSE
       SET v_msg = REPLACE(v_msg, '%1', v_f1);
	   SET v_msg = REPLACE(v_msg, '%2', p_5);
    END IF;

	RETURN(v_msg);
END $$

DELIMITER ;
