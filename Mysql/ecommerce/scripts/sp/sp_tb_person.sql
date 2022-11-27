/*
delete from tb_person;
select * from tb_person;
call sp_tb_person('i', null, 1, 1, 'name 2', '2022-12-31', @sid, @msg);
call sp_tb_person('u', 1, 1, 1, 'name 1', '2021-01-01', @sid, @msg);
call sp_tb_person('d', 0, null, null, null, null, @sid, @msg);
call sp_tb_person('s', 1, null, null, null, null, @sid, @msg);
call sp_tb_person('s', null, null, null, null, null, @sid, @msg);

call sp_tb_person('i', null, 0, 1, 'name 2', '2022-12-31', @sid, @msg);
select @sid, @msg

*/
use ecommerce;

delimiter $$
drop procedure if exists sp_tb_person;
create procedure sp_tb_person
(
	in p_action char(1),
	in p_id int,
	in p_type_id int,
	in p_classification_id int,
    in p_name varchar(50),
	in p_birth date,
    out sid int,
    out msg varchar(500)
)
language sql
deterministic
sql security definer
comment 'manage order and order items'
sp: begin

    declare v_count int default 0;
	declare v_value varchar(500) default '';    

	set sid = 0;
	set msg = '';
    set p_action = upper(p_action);
    
	if p_action not in ('I', 'U', 'D', 'S') then
        select fn_msg(1, '', 1) into msg;
		leave sp;
    end if;

	if p_action = 'U' or p_action = 'D' then
    
		if p_id is null or p_id = 0 then
			select fn_msg(2, fn_label('tb_person.id'), 1) into msg;
			leave sp;
		end if;
                
        select count(id) into v_count from tb_person where id = p_id;        
		if v_count = 0 then
			v_value = concat(fn_label('tb_person.id'), ',', p_id, ',', fn_label('tb_person'));
			select fn_msg(3, v_value, 3) into msg;
			leave sp;
		end if;

    end if;
    
	if p_action = 'I' or p_action = 'U' then
    
		-- mandatory
		if p_type_id is null or p_type_id = 0 then
			v_value = fn_label('tb_person.type_id');
			select fn_msg(2, v_value, 1) into msg;
			leave sp;
		end if;

		-- field size
		if length(p_name) > 50 then
			select fn_get_message(4, 'tb_person', 'name', '', '') into msg;
			leave sp;
		end if;
       
		-- foreign keys		
		select id from tb_person_type where id = p_type_id;
        if found_rows() = 0 then
			select fn_get_message(3, 'tb_person', 'type_id', 'tb_person_type', 'id') into msg;
			leave sp;
        end if;		

	end if;    

    if p_action = "i" then

		insert into tb_person
		(
			classification_id,
			type_id,
			name,
			birth
		) values (
			p_classification_id,
			p_type_id,
			p_name,
			p_birth
		);       

    elseif p_action = "u" then

		update tb_person set
			classification_id = p_classification_id,
			type_id = p_type_id,
			name = p_name,
			birth = p_birth
		where id = p_id;
        
    elseif p_action = "d" then

		delete from tb_person where id = p_id;

    elseif p_action = "s" then

		if p_id is null then
			select * from tb_person;
        else
			select * from tb_person where id = p_id;
  		end if;

    end if;

	set sid = 1;
	set msg = 'processado com sucesso !!!';
end
$$