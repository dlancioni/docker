/*
select fn_success('I', 1);
select fn_success('U', 2);
select fn_success('D', 3);
select * from tb_message
*/
create or replace function fn_success (p_action char(1), p_id int)
returns text
language plpgsql
as
$$
declare
    v_id int default 0;
	v_msg tb_message.message%type default '';
begin
    if p_action = 'I' then
		v_id = 10;
	elseif p_action = 'U' then
		v_id = 11;
	elseif p_action = 'D' then
		v_id = 12;
    end if;    
   
	select message into v_msg from tb_message where id = v_id limit 1;   
	
	v_msg = replace(v_msg, '%1', p_id::text);

	return(v_msg);
end
$$;