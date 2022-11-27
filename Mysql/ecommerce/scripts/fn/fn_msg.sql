/*
select fn_msg(2, 'Id', 1);
select fn_msg(3, 'id, Pessoas, 7', 3);

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
    declare v_tmp varchar(500) default '';
    declare v_value varchar(500) default '';
    declare v_table varchar(500) default '';
    declare v_field varchar(500) default '';
	declare v_msg varchar(500) default '';

    select message into v_msg from tb_message where id = p_id;

    loop_1: loop    
		set v_count = v_count + 1;
        
        set v_value = fn_split(p_values, ',', v_count);
        
        if instr(v_value, 'tb_') > 0 then

			set v_table = fn_aplit(v_value, '.', 1);
            set v_field = fn_aplit(v_value, '.', 2);

			select 
			table_label,
			field_label 
			into v_table, v_field
			from vw_table_field
			where table_name = v_table
			and field_name = v_field;

        end if;

        set v_msg = replace(v_msg, concat('%', v_count), v_value);
        if v_count > p_count then
            leave loop_1;
        end if;
        
    end loop loop_1;

	return(v_msg);
end $$

delimiter ;
