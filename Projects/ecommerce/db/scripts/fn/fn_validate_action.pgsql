/*
select fn_validate_action('I')
select fn_validate_action('ZZ')
*/
create or replace function fn_validate_action (p_action char(1))
returns text
language plpgsql
as
$$
declare
	v_msg text default '';
begin
	if upper(p_action) not in ('I', 'U', 'D', 'S') then
		select message into v_msg from tb_message where id = 1 limit 1;
    end if;
	return(v_msg);
end 
$$;