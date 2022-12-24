/*
select fn_success('I', 1);
select fn_success('U', 2);
select fn_success('D', 3);
select * from tb_message
*/
use ecommerce;

delimiter $$
drop function if exists fn_success;
create function fn_success
(
	p_action char(1),
    p_id int
)
returns varchar(500)
deterministic
begin

    declare v_id int default 0;
	declare v_msg varchar(500) default '';

    if p_action = 'I' then
		set v_id = 10;
	elseif p_action = 'U' then
		set v_id = 11;
	elseif p_action = 'D' then
		set v_id = 12;
    end if;
    
	select message into v_msg from tb_message where id = v_id limit 1;
    
	set v_msg = replace(v_msg, '%1', p_id);

	return(v_msg);

end $$

delimiter ;
