/*
set @sid = 1;
set @msg = '';
call sp_order(0, 1, 1, 10, 1.99, '', @sid, @msg);
select @sid, @msg;

select * from tb_order;
select * from tb_order_item;
delete from tb_order_item;
delete from tb_order;

*/
USE ecommerce;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_order;
CREATE PROCEDURE sp_order
(
	IN p_order_id INT,
	IN p_person_id INT,
	IN p_product_id INT,
	IN p_quantity INT,
	IN p_price DOUBLE,
    IN p_description varchar(500),
    OUT sid INT,
    OUT msg VARCHAR(500)
)
LANGUAGE SQL
DETERMINISTIC
SQL SECURITY DEFINER
COMMENT 'Manage order and order items'
BEGIN

DECLARE v_order_id INT DEFAULT 1;
DECLARE v_order_item_id INT DEFAULT 1;
DECLARE p_date INT DEFAULT curdate();

DECLARE exit handler for sqlexception
BEGIN
	ROLLBACK;
END;

START TRANSACTION;

	INSERT INTO tb_order 
	(
		id, 
		person_id, 
		date,
        description
	) VALUES (
		v_order_id,
		p_person_id,
		p_date,
        p_description
	);

	INSERT INTO tb_order_item 
	(
		id, 
		order_id, 
		product_id,
		quantity, 
		price
	) VALUES (
		v_order_item_id,
		v_order_id,
		p_product_id,
		p_quantity,
		p_price
	);

	-- SUCCESS
	SET sid = 1;
	SET msg = 'Processado com sucesso !!!';

COMMIT;
END
$$