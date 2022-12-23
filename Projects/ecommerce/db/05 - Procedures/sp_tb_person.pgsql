/*
delete from tb_person
select * from tb_person
select * from tb_person_type
select * from tb_person_classification

do
$$
declare
	action tp_action default (2, 99, 0, '', 0);
begin

	action = (1, 99, 0, '', 0);
	-- call sp_tb_person(action, 2, 1, 1, 'David Lancioni', '1979-02-15');

	action = (2, 99, 0, '', 0);
	-- call sp_tb_person(action, 7, 1, 1, 'David Lancioni', '1979-02-15');	

	action = (3, 99, 0, '', 0);
	call sp_tb_person(action, 5);	

    raise notice 'Output: %', action.message;
end
$$;



*/

create or replace procedure sp_tb_person
(
	p_action inout tp_action,
	p_id int,
	p_type_id int default 0,
	p_classification_id int  default 0,
    p_name text  default '',
	p_birth date default null
)
language plpgsql
as
$$

declare
    v_count int default 0;

begin

	-- Initialize status	
	p_action.status = 0;
	p_action.message = '';
	p_action.last_id = 0;

	raise notice 'parametro % ', p_action.id; 

    -- Valid action
    select fn_validate_action(p_action.id) into p_action.message;
	if p_action.message <> '' then
		return; 
	end if;

    -- Mandatory fields
    select fn_validate_mandatory(p_action.id, p_name, 'tb_person', 'name') into p_action.message;
	if p_action.message <> '' then 
		return; 
	end if;

	-- Validate fk
    select count(id) into v_count from tb_person_type where id = p_type_id;
    select fn_validate_fk(p_action.id, v_count, 'tb_person', 'type_id', 'tb_person_type', 'id') into p_action.message;
	if p_action.message <> '' then 
		-- return;
	end if;

	-- Validate if exists on update and delete
	if p_action.id in (2,3) then
		select count(id) into v_count from tb_person where id = p_id;
		if v_count = 0 then
			select fn_not_found(p_action.id, p_id) into p_action.message;
			return;
		end if;	
	end if;
	
	-- Persist data
    if p_action.id = 1 then

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
		)
		returning id into p_action.last_id;

    elseif p_action.id = 2 then

        if v_count = 0 then
			select fn_not_found(p_action.id, p_id) into p_action.message;

        else
			update tb_person set
				classification_id = p_classification_id,
				type_id = p_type_id,
				name = p_name,
				birth = p_birth
			where id = p_id;           
        end if;
        
		-- p_action.last_id = p_id;
        
    elseif p_action.id = 3 then
    
        if v_count = 0 then
			select fn_not_found(p_action.id, p_id) into p_action.message;
        else    
			delete from tb_person where id = p_id;
        end if;    
        
		-- p_action.last_id = p_id;        

    end if;

    if trim(p_action.message) = '' then
		select fn_success(p_action.id, p_action.last_id) into p_action.message;
    end if;

	p_action.status = 1;
end
$$
