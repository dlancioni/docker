/*
select fn_fk_msg(3, 'tb_person', 'id', 'tb_person', 'id', '5');
*/
use ecommerce;

delimiter $$
drop function if exists fn_fk_msg;
create function fn_fk_msg
(
    p_id int,
    p_1 varchar(50),
    p_2 varchar(50),
	p_3 varchar(50),
    p_4 varchar(50),
    p_5 varchar(50)
)
returns varchar(500)
deterministic
begin
	declare v_msg varchar(500) default '';

    declare v_t1 varchar(50) default '';
    declare v_f1 varchar(50) default '';
    declare v_t2 varchar(50) default '';
    declare v_f2 varchar(50) default '';

    select message into v_msg from tb_message where id = p_id;

    select 
    table_label, 
    field_label 
    into v_t1, v_f1 
    from vw_table_field 
    where table_name = p_1
    and field_name = p_2;

    select 
    table_label, 
    field_label 
    into v_t2, v_f2
    from vw_table_field 
    where table_name = p_3
    and field_name = p_4;

    if p_id in (3, 4, 5) then
       set v_msg = replace(v_msg, '%1', v_f1);
	   set v_msg = replace(v_msg, '%2', v_t2);
	   set v_msg = replace(v_msg, '%3', p_5);
    else
       set v_msg = replace(v_msg, '%1', v_f1);
	   set v_msg = replace(v_msg, '%2', p_5);
    end if;

	return(v_msg);
end $$

delimiter ;
