/*
select fn_validate_action(1)
select fn_validate_action(99)
*/
create or replace function fn_validate_action 
(
	p_action int
)
returns text
language plpgsql
as
$$
declare
	v_msg text default '';
begin
	if upper(p_action) not in (1, 2, 3) then
		select message into v_msg from tb_message where id = 1 limit 1;
    end if;
	return(v_msg);
end 
$$;