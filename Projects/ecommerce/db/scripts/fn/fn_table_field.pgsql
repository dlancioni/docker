/*
select fn_table_field('tb_person', '' );
select fn_table_field('tb_person', 'id' );
select fn_table_field('tb_person', 'name' );
*/
create or replace function fn_table_field (p_table_name text, p_field_name text)
returns text
language plpgsql
as
$$
declare
	v_value text default '';
begin    
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
end
$$;