/*
call sp_test(1)
*/
delimiter $$
drop procedure if exists sp_test;
create procedure sp_test
(
	in p_id int
)
deterministic
comment 'manage order and order items'
sp: begin
		call sp_output(1, 'Mensagem de teste', p_id);
    end$$
delimiter ;
