/*
select fn_validate_fk_insert('I', 3, 'tb_person', 'id', 'tb_person_type', 'id');
select fn_validate_fk_insert('U', 3, 'tb_person', 'id', 'tb_person_type', 'id');
select fn_validate_fk_insert('D', 3, 'tb_person', 'id', 'tb_person_type', 'id');
*/
use ecommerce;

delimiter $$
drop function if exists fn_validate_fk_insert;
create function fn_validate_fk_insert
(
	p_action char(1),
    p_id int,
    p_t1 varchar(50),
    p_f1 varchar(50),
    p_t2 varchar(50),
    p_f2 varchar(50)
)
returns varchar(500)
deterministic
begin

	declare v_msg varchar(500) default '';
    declare v_table varchar(50) default '';
    declare v_field varchar(50) default '';

	if p_action in ('I', 'U') then
    
		select message into v_msg from tb_message where id = 3 limit 1;

		select 
		table_label, 
		field_label 
		into v_table, v_field
		from tb_table_field 
		where table_name = p_t1
		and field_name = p_f1;

		set v_msg = replace(v_msg, '%1', v_table);
		
		select 
		table_label,
		field_label
		into v_table, v_field
		from tb_table_field
		where table_name = p_t2
		and field_name = p_f2;
		
		set v_msg = replace(v_msg, '%2', v_table);
        
    end if;

	if p_action = 'D' then

		select message into v_msg from tb_message where id = 5 limit 1;

		select 
		table_label, 
		field_label 
		into v_table, v_field
		from tb_table_field 
		where table_name = p_t2
		and field_name = p_f2;

		set v_msg = replace(v_msg, '%1', v_table);
        
    end if;

	return(v_msg);

end $$

delimiter ;
