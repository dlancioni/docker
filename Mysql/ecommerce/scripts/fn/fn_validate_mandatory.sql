/*
select fn_validate_mandatory(3, 'tb_person_type', 'NAME');
select * from tb_message
*/
use ecommerce;

delimiter $$
drop function if exists fn_validate_mandatory;
create function fn_validate_mandatory
(
	p_action char(1),
	p_value varchar(50),
    p_t1 varchar(50),
    p_f1 varchar(50)
)
returns varchar(500)
deterministic
begin
	declare MSG_MANDATORY int default 4;    
	declare v_msg varchar(500) default '';
    declare v_table varchar(50) default '';
    declare v_field varchar(50) default '';
    
    if p_action in ('I', 'U') then
    
		if trim(p_value) = '' or trim(p_value) = '0' or trim(p_value) is null then

			select message into v_msg from tb_message where id = MSG_MANDATORY limit 1;

			select 
			table_label, 
			field_label 
			into v_table, v_field
			from tb_table_field 
			where table_name = p_t1
			and field_name = p_f1;

			set v_msg = replace(v_msg, '%1', v_field);

		end if;    

    end if;
    
	return(v_msg);

end $$

delimiter ;
