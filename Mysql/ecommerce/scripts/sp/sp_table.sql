/*
delete from tb_person;
select * from tb_person;
--
call sp_table('I', 'tb_person', '0, 1, 1, David Lancioni, 1979-02-15', @sid, @msg);
call sp_table('I', 'tb_person', '0, 1, 1, Renata Caramelli, 1979-02-15', @sid, @msg);
call sp_table('U', 'tb_person', '22, 1, 1, David C Lancioni, 1979-02-01', @sid, @msg);
call sp_table('D', 'tb_person', '23', @sid, @msg);
call sp_table('S', 'tb_person', '', @sid, @msg);
call sp_table('S', 'tb_person', '22', @sid, @msg);
--
call sp_table('I', 'tb_person', '0, 1, 1, David Lancioni, 1979-02-15', @sid, @msg);
select @sid, @msg
*/
USE ecommerce;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_table;
CREATE PROCEDURE sp_table
(
	IN p_action char(1),
	IN p_table_name VARCHAR(500),
	IN p_values VARCHAR(500),
    OUT sid INT,
    OUT msg VARCHAR(500)
)
LANGUAGE SQL
DETERMINISTIC
SQL SECURITY DEFINER
COMMENT 'Table maintenence for given table'
sp: BEGIN

    DECLARE v_table_name varchar(100) DEFAULT "";
    DECLARE v_field_name varchar(100) DEFAULT "";
    DECLARE v_field_type varchar(100) DEFAULT "";
    DECLARE v_field_size varchar(100) DEFAULT "";
    DECLARE v_field_nullable varchar(100) DEFAULT "";

	DECLARE v_id VARCHAR(10) DEFAULT '';
	DECLARE v_row INTEGER DEFAULT 0;
    DECLARE v_tmp VARCHAR(500) DEFAULT '';
    DECLARE v_row_count INTEGER DEFAULT 0;
    DECLARE v_fields VARCHAR(500) DEFAULT '';
    DECLARE v_values VARCHAR(500) DEFAULT '';

    DECLARE v_select VARCHAR(500) DEFAULT '';
    DECLARE v_insert VARCHAR(500) DEFAULT '';
    DECLARE v_update VARCHAR(500) DEFAULT '';
    DECLARE v_delete VARCHAR(500) DEFAULT '';

	DECLARE finished INTEGER DEFAULT 0;

	DECLARE cursor_table CURSOR FOR
	SELECT
	t1.table_name,
	t2.column_name,
	t2.data_type,
	IFNULL(t2.character_maximum_length, 0) numeric_precision,
	t2.is_nullable
	FROM information_schema.tables t1
	INNER JOIN information_schema.columns t2 ON
	t1.table_name = t2.table_name 
    and t1.table_schema = t2.table_schema
	WHERE t1.table_schema = 'ecommerce'
	AND t1.table_name = p_table_name
	ORDER BY t2.ordinal_position;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
	OPEN cursor_table;

	SET v_id = fn_split(p_values, ',', 1);
	select FOUND_ROWS() into v_row_count;

	loop_table: LOOP
    
		FETCH cursor_table INTO v_table_name, v_field_name, v_field_type, v_field_size, v_field_nullable;

		IF finished = 1 THEN
			LEAVE loop_table;
		END IF;

		SET v_row = v_row + 1;

        IF lower(v_field_name) <> 'id' THEN

            SET v_tmp = concat("'", fn_split(p_values, ',', v_row), "'");
			IF upper(v_field_type) in ('INTEGER', 'INT', 'SMALLINT', 'TINYINT', 'MEDIUMINT', 'BIGINT', 'DECIMAL', 'NUMERIC', 'FLOAT', 'DOUBLE') THEN
				SET v_tmp = replace(v_tmp, "'", "");
			END IF;

			SET v_fields = concat(v_fields, v_field_name);
			SET v_values = concat(v_values, v_tmp);
			SET v_update = concat(v_update, v_field_name, '=',  v_tmp);

			IF v_row < v_row_count THEN
				SET v_fields = concat(v_fields, ', ');
				SET v_values = concat(v_values, ', ');
				SET v_update = concat(v_update, ', ');
			END IF;

        END IF;

	END LOOP loop_table;
	CLOSE cursor_table;
    
        

    IF p_action = "I" THEN   
		SET v_insert = concat('insert into ', p_table_name, ' (', v_fields, ' ) values (', v_values, ');');
		SET @SQL = v_insert;
    ELSEIF p_action = "U" THEN
		SET v_update = concat('update ', p_table_name, ' set ', v_update, ' where id = ', v_id);
		SET @SQL = v_update;
    ELSEIF p_action = "D" THEN		
        SET v_delete = concat('DELETE FROM tb_person WHERE id = ', v_id);
        SET @SQL = v_delete;
    ELSEIF p_action = "S" THEN
		IF v_id is NULL OR v_id = 0 THEN
            SET v_select = concat('SELECT * FROM tb_person');
            SET @SQL = v_select;
        ELSE
			SET v_select = concat('SELECT * FROM tb_person WHERE id = ', v_id);
			SET @SQL = v_select;
  		END IF;
    END IF;

	PREPARE stmt FROM @SQL;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END
$$