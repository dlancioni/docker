/*
select fn_not_found('U', 1);
select fn_not_found('D', 1);
select * from tb_message
*/
use ecommerce;

delimiter $$
drop function if exists fn_not_found;
create function fn_not_found
(
	p_action char(1),
	p_id int
)
returns varchar(500)
deterministic
begin

	declare v_msg varchar(500) default '';

    if p_action in ('U', 'D') then

		select message into v_msg from tb_message where id = 6 limit 1;

		set v_msg = replace(v_msg, '%1', p_id);

		if p_action = 'U' then
			set v_msg = replace(v_msg, '%2', 'alteração');
		end if;

		if p_action = 'D' then
			set v_msg = replace(v_msg, '%2', 'exclusão');
		end if;

    end if;
    
	return(v_msg);

end $$

delimiter ;
