/*
call sp_test(1, @output); select @output
*/
delimiter $$
drop procedure if exists sp_test;
create procedure sp_test
(
	in p_user_id int,
    out p_output text
)
deterministic
comment 'manage order and order items'
sp: begin
		select fn_output(1, 'Mensagem de teste', 99) into p_output;
    end$$
delimiter ;
