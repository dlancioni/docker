/*
select fn_msg(12);
 */
create or replace function fn_msg(p_id int)
returns text
language plpgsql
as
$$
declare
    v_msg tb_message.message%type default '';
begin
    select trim(message) into v_msg from tb_message where id = p_id limit 1;
    return v_msg;
end;
$$