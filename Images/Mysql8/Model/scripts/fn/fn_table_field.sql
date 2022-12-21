/*
select fn_label('tb_person', '' );
select fn_label('tb_person', 'id' );
select fn_label('tb_person', 'name' );
 */
use ecommerce;

delimiter $$
drop function if exists fn_table_field;
create function fn_table_field
(
    p_table_name varchar(50),
    p_field_name varchar(50)
)
returns varchar(50)
deterministic
begin

	declare v_value varchar(50) default '';
    
    if p_field_name = '' then
		select 
		table_label 
		into v_value
		from tb_table_field
		where table_name = p_table_name
		limit 1;       
    else    
		select 
		field_label 
		into v_value
		from tb_table_field
		where table_name = p_table_name
		and field_name = p_field_name
		limit 1;            
    end if;

	return(v_value);
end $$
delimiter ;
