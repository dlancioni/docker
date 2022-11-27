/*
delete from tb_person;
select * from tb_person;

call sp_tb_person('I', null, 1, 1, 'name 2', '2022-12-31', @v_st, @v_msg);
call sp_tb_person('U', 1, 1, 1, 'name 1', '2021-01-01', @v_st, @v_msg);
call sp_tb_person('D', 0, null, null, null, null, @v_st, @v_msg);
call sp_tb_person('S', 28, null, null, null, null, @v_st, @v_msg);
call sp_tb_person('S', null, null, null, null, null, @v_st, @v_msg);

call sp_tb_person('I', null, 11, 1, 'name 2', '2022-12-31', @v_st, @v_msg);
select @v_st, @v_msg

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
    out v_st int,
    out v_msg varchar(500)
)
language sql
deterministic
sql security definer
comment 'manage order and order items'
sp: begin

    DECLARE C_VALIDATION_VALID_ACTION INT DEFAULT 1;
	DECLARE C_VALIDATION_MANDATORY_FIELD INT DEFAULT 2;
    DECLARE C_VALIDATION_NOT_FOUND INT DEFAULT 3;
    DECLARE C_VALIDATION_FK_INSERT INT DEFAULT 4;
    
    DECLARE C_SUCCESS_INSERT INT DEFAULT 10;
    DECLARE C_SUCCESS_UPDATE INT DEFAULT 11;
    DECLARE C_SUCCESS_DELETE INT DEFAULT 12;    

    declare v_count int default 0;
	declare v_value varchar(500) default '';    

	set v_st = 0;
	set v_msg = '';
    set p_action = upper(p_action);
    
	if p_action not in ('I', 'U', 'D', 'S') then
		set v_value = '';
        select fn_msg(C_VALIDATION_VALID_ACTION, v_value, 1) into v_msg;
		leave sp;
    end if;

	if p_action = 'U' or p_action = 'D' then
    
		if p_id is null or p_id = 0 then
			set v_value = fn_label('tb_person.id');
			select fn_msg(C_VALIDATION_MANDATORY_FIELD, v_value, 1) into v_msg;
			leave sp;
		end if;
                
        select count(id) into v_count from tb_person where id = p_id;        
		if v_count = 0 then
			set v_value = concat(fn_label('tb_person.id'), ',', p_id, ',', fn_label('tb_person'));
			select fn_msg(C_VALIDATION_NOT_FOUND, v_value, 3) into v_msg;
			leave sp;
		end if;

    end if;
    
	if p_action = 'I' or p_action = 'U' then
    
		if p_type_id is null or p_type_id = 0 then
			set v_value = fn_label('tb_person.type_id');
			select fn_msg(C_VALIDATION_MANDATORY_FIELD, v_value, 1) into v_msg;
			leave sp;
		end if;

        select count(id) into v_count from tb_person_type where id = p_type_id;
		if v_count = 0 then              
			set v_value = concat(fn_label('tb_person.type_id'), ',', p_type_id, ',', fn_label('tb_person_type'));
  			select fn_msg(C_VALIDATION_FK_INSERT, v_value, 3) into v_msg;
			leave sp;
        end if;		

	end if;    

    if p_action = "I" then

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
        
		select fn_msg(C_SUCCESS_INSERT, '', 1) INTO v_msg;

    elseif p_action = "U" then

		update tb_person set
			classification_id = p_classification_id,
			type_id = p_type_id,
			name = p_name,
			birth = p_birth
		where id = p_id;
        
		select fn_msg(C_SUCCESS_UPDATE, '', 1) into v_msg;
        
    elseif p_action = "D" then

		delete from tb_person where id = p_id;
		select fn_msg(C_SUCCESS_DELETE, '', 1) into v_msg;

    elseif p_action = "S" then

		if p_id is null or p_id = 0 then
			select * from tb_person;
        else
			select * from tb_person where id = p_id;
  		end if;

    end if;

	set v_st = 1;

end
$$