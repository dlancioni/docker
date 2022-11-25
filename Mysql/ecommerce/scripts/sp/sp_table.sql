/*
delete from tb_person;
select * from tb_person;
--
call sp_table('I', 'tb_person', '0, 1, 1, David Lancioni, 1979-02-15', @p_st, @p_msg, @p_id);
select @p_st, @p_msg, @p_id

call sp_table('U', 'tb_person', '22, 1, 1, David C Lancioni, 1979-02-01', @p_st, @p_msg, @p_id);
select @p_st, @p_msg, @p_id

call sp_table('D', 'tb_person', '19, 1, 1, David C Lancioni, 1979-02-01', @p_st, @p_msg, @p_id);
select @p_st, @p_msg, @p_id
--
*/
USE ecommerce;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_table;
CREATE PROCEDURE sp_table
(
	IN p_action char(1),
	IN p_table_name VARCHAR(500),
	IN p_values VARCHAR(500),
    OUT p_st INT,
    OUT p_msg VARCHAR(500),
	OUT p_id INT
)
LANGUAGE SQL
DETERMINISTIC
SQL SECURITY DEFINER
COMMENT 'Table maintenence for given table'
sp: BEGIN

    DECLARE C_VALIDATION_VALID_ACTION INT DEFAULT 1;
	DECLARE C_VALIDATION_MANDATORY_FIELD INT DEFAULT 2;
    DECLARE C_VALIDATION_RECORD_NOT_FOUND_UPDATE_DELETE INT DEFAULT 3;
    DECLARE C_VALIDATION_SIZE_LIMIT INT DEFAULT 4;
    
    DECLARE C_SUCCESS_INSERT INT DEFAULT 10;
    DECLARE C_SUCCESS_UPDATE INT DEFAULT 11;
    DECLARE C_SUCCESS_DELETE INT DEFAULT 12;

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
	select FOUND_ROWS() into v_row_count;    
    
    SET p_st = 0;
    SET p_msg  = '';
	SET p_id = 0;

    -- Validate the action
	IF p_action NOT IN ('I', 'U', 'D', 'S') THEN
        SELECT fn_get_message(C_VALIDATION_VALID_ACTION, '', '', '', '', '') INTO p_msg;
		LEAVE sp;
    END IF;

    -- Validate Id (mandatory for update or delete)
	IF p_action IN ('U', 'D') THEN   
		SET v_id = fn_split(p_values, ',', 1);        
		IF v_id = '' OR v_id = '0' or v_id IS NULL THEN
			SELECT fn_get_message(C_VALIDATION_MANDATORY_FIELD, p_table_name, 'id', '', '', '') INTO p_msg;
			LEAVE sp;
		END IF;        
		SET @SQL = concat('SELECT * FROM ', p_table_name, ' WHERE id = ', v_id);
		PREPARE stmt FROM @SQL;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;        
        IF FOUND_ROWS() = 0 THEN
            SET p_id = v_id;        
			SELECT fn_get_message(C_VALIDATION_RECORD_NOT_FOUND_UPDATE_DELETE, p_table_name, 'id', p_table_name, 'id', v_id) INTO p_msg;
			LEAVE sp;
        END IF;        
    END IF;

	SET v_id = fn_split(p_values, ',', 1);

	loop_table: LOOP
    
		FETCH cursor_table INTO v_table_name, v_field_name, v_field_type, v_field_size, v_field_nullable;

		IF finished = 1 THEN
			LEAVE loop_table;
		END IF;

		SET v_row = v_row + 1;

        IF lower(v_field_name) <> 'id' THEN

            SET v_tmp = fn_split(p_values, ',', v_row);
            
            IF upper(v_field_nullable) = 'NO' THEN
				IF v_tmp = '' OR v_tmp = '0'  THEN
					SELECT fn_get_message(C_VALIDATION_MANDATORY_FIELD, v_table_name, v_field_name, '', '', '') INTO p_msg;
					LEAVE sp;
				END IF;
            END IF;
            
			IF upper(v_field_type) in ('CHAR', 'VARCHAR') THEN
				IF LENGTH(v_tmp) > v_field_size THEN
					SELECT fn_get_message(C_VALIDATION_SIZE_LIMIT, v_table_name, v_field_name, '', '', v_field_size) INTO p_msg;
					LEAVE sp;
                END IF;
			END IF;

			IF upper(v_field_type) not in ('INTEGER', 'INT', 'SMALLINT', 'TINYINT', 'MEDIUMINT', 'BIGINT', 'DECIMAL', 'NUMERIC', 'FLOAT', 'DOUBLE') THEN
				SET v_tmp = concat("'", fn_split(p_values, ',', v_row), "'");
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
      	SELECT fn_get_message(C_SUCCESS_INSERT, '', '', '', '', '') INTO p_msg;
    ELSEIF p_action = "U" THEN
		SET v_update = concat('update ', p_table_name, ' set ', v_update, ' where id = ', v_id);
		SET @SQL = v_update;
      	SELECT fn_get_message(C_SUCCESS_UPDATE, '', '', '', '', '') INTO p_msg;
    ELSEIF p_action = "D" THEN		
        SET v_delete = concat('DELETE FROM tb_person WHERE id = ', v_id);
        SET @SQL = v_delete;
      	SELECT fn_get_message(C_SUCCESS_DELETE, '', '', '', '', '') INTO p_msg;
    END IF;

	PREPARE stmt FROM @SQL;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;

	SET p_id = LAST_INSERT_ID();
    SET p_st = 1;
END
$$