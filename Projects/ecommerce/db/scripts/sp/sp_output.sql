/*
call sp_test(1, @output); select @output
*/
delimiter $$
drop procedure if exists sp_output;
create procedure sp_output
(
	p_status int,
	p_msg text,
    p_id int
)
deterministic
comment 'manage order and order items'
sp: begin
		select p_status status, p_msg message, p_id id;
    end$$
delimiter ;
