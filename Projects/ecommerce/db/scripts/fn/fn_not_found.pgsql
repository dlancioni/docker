/*
select fn_not_found(2, 1); -- Update
select fn_not_found(3, 2); -- Delete
select * from tb_message
*/
create or replace function fn_not_found
(
	p_action int, 
	p_id int
)
returns text
language plpgsql
as
$$
declare
	v_msg tb_message.message%type default '';
begin	
    if p_action in (2, 3) then

		select message into v_msg from tb_message where id = 6 limit 1;

		v_msg = replace(v_msg, '%1', p_id::text);

		if p_action = 2 then
			v_msg = replace(v_msg, '%2', 'alteração');
		end if;

		if p_action = 3 then
			v_msg = replace(v_msg, '%2', 'exclusão');
		end if;

    end if;
    
	return(v_msg);
end 
$$;
