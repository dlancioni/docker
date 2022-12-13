/*
select fn_validate_action('I')
*/
use ecommerce;

delimiter $$
drop function if exists fn_validate_action;
create function fn_validate_action
(
    p_action char(1)
)
returns varchar(500)
deterministic
begin

	declare v_msg varchar(500) default '';

	if upper(p_action) not in ('I', 'U', 'D', 'S') then
		select message into v_msg from tb_message where id = 1 limit 1;
    end if;

	return(v_msg);
end $$

delimiter ;
