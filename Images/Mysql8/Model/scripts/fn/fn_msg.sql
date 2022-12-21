/*
select fn_msg(1);
 */
use ecommerce;

delimiter $$
drop function if exists fn_msg;
create function fn_msg
(
    p_id int
)
returns varchar(500)
deterministic
begin

	declare v_msg varchar(500) default '';

    select trim(message) into v_msg from tb_message where id = p_id limit 1;

	return(v_msg);
end $$
delimiter ;
