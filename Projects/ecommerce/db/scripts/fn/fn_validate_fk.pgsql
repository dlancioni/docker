/*
select fn_validate_fk('I', 0, 'tb_person', 'id', 'tb_person_type', 'id');
select fn_validate_fk('U', 0, 'tb_person', 'id', 'tb_person_type', 'id');
select fn_validate_fk('D', 1, 'tb_person', 'id', 'tb_person_type', 'id');
*/
create or replace function fn_validate_fk
(
	p_action int,
    p_count int,
    p_t1 text,
    p_f1 text,
    p_t2 text,
    p_f2 text
)
returns text
language plpgsql
as
$$
declare
	v_msg text default '';
    v_table text default '';
    v_field text default '';

begin

	if p_action in (1, 2) then

		if p_count = 0 then
    
			select message into v_msg from tb_message where id = 3 limit 1;

			select 
			table_label, 
			field_label 
			into v_table, v_field
			from vw_table_field 
			where table_name = p_t1
			and field_name = p_f1
		    limit 1;

			v_msg = replace(v_msg, '%1', v_field);
			
			select 
			table_label, 
			field_label 
			into v_table, v_field
			from vw_table_field 
			where table_name = p_t2
			and field_name = p_f2
		    limit 1;
			
			v_msg = replace(v_msg, '%2', v_table);

        end if;

    end if;

	if p_action = 3 then

		if p_count > 0 then

			select message into v_msg from tb_message where id = 5 limit 1;

			select 
			table_label, 
			field_label 
			into v_table, v_field
			from vw_table_field 
			where table_name = p_t2
			and field_name = p_f2
		    limit 1;

			v_msg = replace(v_msg, '%1', v_table);
        
        end if;
        
    end if;

	return(v_msg);

end 
$$;
