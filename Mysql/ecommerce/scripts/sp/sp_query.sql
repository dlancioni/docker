/*
select * from tb_person;
call sp_query('tb_person', 0, 0, 0);   -- all
call sp_query('tb_person', 2, 0, 0);   -- one
call sp_query('tb_person', 0, 5, 0);   -- limit
call sp_query('tb_person', 0, 2, 5);   -- limit
*/
USE ecommerce;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_query;
CREATE PROCEDURE sp_query
(
	IN p_table_name VARCHAR(500),
	IN p_id INT,
	IN p_limit INT,
	IN p_offset INT    
)
LANGUAGE SQL
DETERMINISTIC
SQL SECURITY DEFINER
COMMENT 'Dynamic table query'
sp: BEGIN
    
    DECLARE v_select VARCHAR(500) DEFAULT '';    
    
    SET v_select = concat('SELECT * FROM ', p_table_name);
    
	IF p_id IS NOT NULL AND p_id <> 0 THEN
		SET v_select = concat(v_select, ' WHERE id = ', p_id);
	END IF;
    
	IF p_limit IS NOT NULL AND p_limit <> 0 THEN
		SET v_select = concat(v_select, ' LIMIT ', p_limit);
	END IF;
    
	IF (p_limit IS NOT NULL AND p_limit <> 0) AND (p_offset IS NOT NULL AND p_offset <> 0) THEN
		SET v_select = concat(v_select, ' OFFSET ', p_offset);
	END IF;    
    
    SET @SQL = v_select;
	PREPARE stmt FROM @SQL;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END
$$