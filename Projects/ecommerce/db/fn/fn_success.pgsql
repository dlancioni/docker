/*
select fn_success(1, 1); -- Insert
select fn_success(2, 2); -- Update
select fn_success(3, 3); -- Delete
select * from tb_message
*/
create or replace function fn_success 
(
	p_action int, 
	p_id int
)
returns text
language plpgsql
as
$$
declare
    v_id int default 0;
	v_msg tb_message.message%type default '';
begin
    if p_action = 1 then
		v_id = 10;
	elseif p_action = 2 then
		v_id = 11;
	elseif p_action = 3 then
		v_id = 12;
    end if;    
   
	select message into v_msg from tb_message where id = v_id limit 1;   
	
	v_msg = replace(v_msg, '%1', p_id::text);

	return(v_msg);
end
$$;