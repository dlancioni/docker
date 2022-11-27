/*
select fn_label('tb_person' );
select fn_label('tb_person.id' );
 */
use ecommerce;

delimiter $$
drop function if exists fn_label;
create function fn_label
(
    p_value varchar(50)
)
returns varchar(50)
deterministic
begin

	declare v_table varchar(50) default '';
	declare v_field varchar(50) default '';
	declare v_value varchar(50) default '';
    
    if instr(p_value, '.') > 0 then
		set v_table = fn_split(p_value, '.', 1);
		set v_field = fn_split(p_value, '.', 2);
        
		select field_label 
        into v_value
		from vw_table_field
		where table_name = v_table
		and field_name = v_field
		limit 1;        
        
    else    
		set v_table = p_value;
       
		select 
		table_label 
		into v_value
		from vw_table_field
		where table_name = v_table
		limit 1;
        
    end if;    

	return(v_value);
end $$
delimiter ;
