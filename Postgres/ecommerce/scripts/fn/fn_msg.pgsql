/*
select fn_msg(11);
 */
create or replace function fn_msg(p_id int)
returns varchar(500)
language plpgsql
as
$$
declare 
    v_msg varchar(500) default '';

begin
    -- select trim(message) into v_msg from tb_message where id = p_id limit 1;
	return(p_id);

end;
$$