/*
select fn_not_found('U', 1);
select fn_not_found('D', 2);
select * from tb_message
*/
create or replace function fn_not_found(p_action char(1), p_id int)
returns text
language plpgsql
as
$$
declare
	v_msg tb_message.message%type default '';
begin	
    if p_action in ('U', 'D') then

		select message into v_msg from tb_message where id = 6 limit 1;

		v_msg = replace(v_msg, '%1', p_id::text);

		if p_action = 'U' then
			v_msg = replace(v_msg, '%2', 'alteração');
		end if;

		if p_action = 'D' then
			v_msg = replace(v_msg, '%2', 'exclusão');
		end if;

    end if;
    
	return(v_msg);
end 
$$;
