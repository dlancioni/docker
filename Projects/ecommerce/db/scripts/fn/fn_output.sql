/*
select fn_output(1, 'Test', 99);
 */
use ecommerce;

delimiter $$
drop function if exists fn_output;
create function fn_output
(
	p_status int,
	p_msg text,
    p_id int
) 
returns text charset utf8mb3
deterministic
begin

	declare v_output text default '';

    set v_output = concat(p_status, '|', p_msg, '|', p_id);

	return(v_output);

end$$
delimiter ;

