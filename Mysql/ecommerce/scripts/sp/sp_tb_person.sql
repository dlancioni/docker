/*
delete from tb_person
select * from tb_person
select * from tb_person_type
select * from tb_person_classification

call sp_tb_person(1, 'I', 1, 1, 1, 'Name 1', '2022-12-31', @v_st, @v_msg, @v_id);
select @v_st, @v_msg

call sp_tb_person(1, 'U', 2, 2, 3, 'David Lancioni', '1979-02-15', @v_st, @v_msg);
select @v_st, @v_msg

call sp_tb_person(1, 'D', 7, null, null, null, null, @v_st, @v_msg);
select @v_st, @v_msg
*/
use ecommerce;

delimiter $$
drop procedure if exists sp_tb_person;
create procedure sp_tb_person
(
	in p_user_id int,
	in p_action char(1),
	in p_id int,
	in p_type_id int,
	in p_classification_id int,
    in p_name varchar(50),
	in p_birth date,
    out v_st int,
    out v_msg varchar(500),
    out v_id int
)
language sql
deterministic
sql security definer
comment 'manage order and order items'
sp: begin

    declare v_count int default 0;

	set v_st = 0;
	set v_msg = '';
    
    -- Valid action
    select fn_validate_action(p_action) into v_msg;
	if v_msg <> '' then 
		leave sp; 
	end if;

    -- Mandatory fields
    select fn_validate_mandatory(p_action, p_name, 'tb_person', 'name') into v_msg;
	if v_msg <> '' then 
		leave sp; 
	end if;

	-- Validate fk
    select count(id) into v_count from tb_person_type where id = p_type_id;
    select fn_validate_fk(p_action, v_count, 'tb_person', 'type_id', 'tb_person_type', 'id') into v_msg;
	if v_msg <> '' then 
		leave sp; 
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
        
        set v_id = last_insert_id();
		set v_msg = 'Registro incluído com sucesso';
		select fn_msg(6) into v_msg;        

    elseif p_action = "U" then

		update tb_person set
			classification_id = p_classification_id,
			type_id = p_type_id,
			name = p_name,
			birth = p_birth
		where id = p_id;        
        
        set v_id = last_insert_id();        
		select fn_msg(7) into v_msg;
        
    elseif p_action = "D" then

		delete from tb_person where id = p_id;       
        
        set v_id = last_insert_id();        
		select fn_msg(8) into v_msg;

    end if;

	set v_st = 1;
end
$$
