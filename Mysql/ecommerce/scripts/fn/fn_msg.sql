/*
select fn_msg(1, '', 1);
select fn_msg(2, fn_label('tb_person.id'), 1);
select fn_msg(3, 'tb_person.id, tb_person_type.id, 10', 3);
select fn_msg(3, 'tb_person.id, 1, tb_person_type', 3);
 */
use ecommerce;

delimiter $$
drop function if exists fn_msg;
create function fn_msg
(
    p_id int,
    p_values varchar(255),
    p_count int
)
returns varchar(500)
deterministic
begin
	declare v_count int default 0;
    declare v_value varchar(500) default '';
	declare v_msg varchar(500) default '';

    select message into v_msg from tb_message where id = p_id;

    loop_1: loop    
    
		set v_count = v_count + 1;
        set v_value = fn_split(p_values, ',', v_count);
        set v_msg = replace(v_msg, concat('%', v_count), v_value);
        
        if v_count > p_count then
            leave loop_1;
        end if;

    end loop loop_1;

	return(v_msg);
end $$
delimiter ;
