/*
select fn_validate_mandatory('I', '', 'tb_person_type', 'ds');
*/
create or replace function fn_validate_mandatory
(
	p_action int,
	p_value text,
    p_t1 text,
    p_f1 text
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

		if trim(p_value) = '' or trim(p_value) = '0' or trim(p_value) is null then

			select message into v_msg from tb_message where id = 4 limit 1;

			select 
			table_label, 
			field_label 
			into v_table, v_field
			from vw_table_field 
			where table_name = p_t1
			and field_name = p_f1
		    limit 1;

			v_msg = replace(v_msg, '%1', v_field);

		end if;    

    end if;
    
	return(v_msg);

end 
$$;
