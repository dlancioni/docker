/*
delete from tb_person
select * from tb_person
select * from tb_person_type
select * from tb_person_classification

call sp_tb_person(1, 'I', 1, 1, 1, '', '2022-12-31');
call sp_tb_person(1, 'U', 51, 1, 3, 'David C Lancioni', '1979-02-15');
call sp_tb_person(1, 'D', 17, null, null, null, null);

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
	in p_birth date
)
language sql
deterministic
sql security definer
comment 'manage order and order items'
sp: begin

    declare v_count int default 0;
	declare v_status int default 0;
	declare v_msg text default '';
    declare v_id int default 0;
    
    -- Valid action
    select fn_validate_action(p_action) into v_msg;
	if v_msg <> '' then 
		select v_status status, v_msg message, v_id id;
		leave sp; 
	end if;

    -- Mandatory fields
    select fn_validate_mandatory(p_action, p_name, 'tb_person', 'name') into v_msg;
	if v_msg <> '' then 
		select v_status status, v_msg message, v_id id;
		leave sp; 
	end if;

	-- Validate fk
    select count(id) into v_count from tb_person_type where id = p_type_id;
    select fn_validate_fk(p_action, v_count, 'tb_person', 'type_id', 'tb_person_type', 'id') into v_msg;
	if v_msg <> '' then 
		select v_status status, v_msg message, v_id id;
		leave sp; 
	end if;

	select count(id) into v_count from tb_person where id = p_id;

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

    elseif p_action = "U" then

        if v_count = 0 then
			select fn_not_found(p_action, p_id) into v_msg;
        else
			update tb_person set
				classification_id = p_classification_id,
				type_id = p_type_id,
				name = p_name,
				birth = p_birth
			where id = p_id;           
        end if;
        
		set v_id = p_id;        
        
    elseif p_action = "D" then
    
        if v_count = 0 then
			select fn_not_found(p_action, p_id) into v_msg;
        else    
			delete from tb_person where id = p_id;
        end if;    
        
		set v_id = p_id;        

    end if;

    if trim(v_msg) = '' then
		select fn_success(p_action, v_id) into v_msg;
    end if;

	set v_status = 1;
    
	select v_status status, v_msg message, v_id id;
end
$$
