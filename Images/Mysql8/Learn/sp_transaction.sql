/*
David lancioni - 11/23
Generate random number
-- call sp_transactional();
-- select * from tb_profile;
*/
USE security;

DELIMITER $$
drop procedure if exists sp_transactional;
CREATE PROCEDURE sp_transactional()
LANGUAGE SQL
DETERMINISTIC
SQL SECURITY DEFINER
COMMENT 'First SP at Expertdeveloper'
BEGIN

DECLARE exit handler for sqlexception
BEGIN
	ROLLBACK;
    select 'deu pau';
END;

DECLARE exit handler for sqlwarning
BEGIN
	ROLLBACK;
END;

START TRANSACTION;

delete from tb_profile;

INSERT INTO tb_profile ( id, name ) VALUES ( 2, 'master' );

delete from tb_profile1 where id = 2;

COMMIT;
END
$$