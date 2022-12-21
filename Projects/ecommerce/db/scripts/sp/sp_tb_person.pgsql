/*
delete from tb_person
select * from tb_person
select * from tb_person_type
select * from tb_person_classification

do
$$
declare
	v_st int default 0;
	v_msg text default '';
	v_id int default 0;
begin
    call sp_tb_person(1, 'I', 0, 1, 1, 'Name 1', '2022-12-31', v_st, v_msg, v_id);
    raise notice 'Status: %', v_st;
	raise notice 'Message: %', v_msg;
	raise notice 'Id: %', v_id;
end
$$;
*/

create or replace procedure sp_tb_person
(
	p_user_id int,
	p_action char(1),
	p_id int,
	p_type_id int,
	p_classification_id int,
    p_name varchar(50),
	p_birth date,
    v_st out int,
    v_msg out text,
    v_id out int
)
language plpgsql
as
$$

declare
    v_count int default 0;

begin

	-- Initialize status
    v_st = 0;
    v_id = 0;

    -- Valid action
    select fn_validate_action(p_action) into v_msg;
	if v_msg <> '' then
		return; 
	end if;

    -- Mandatory fields
    select fn_validate_mandatory(p_action, p_name, 'tb_person', 'name') into v_msg;
	if v_msg <> '' then 
		return; 
	end if;

	-- Validate fk
    select count(id) into v_count from tb_person_type where id = p_type_id;
    select fn_validate_fk(p_action, v_count, 'tb_person', 'type_id', 'tb_person_type', 'id') into v_msg;
	if v_msg <> '' then 
		return;
	end if;

	select count(id) into v_count from tb_person where id = p_id;

    if p_action = 'I' then

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
		returning id into v_id;

    elseif p_action = 'U' then

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
        
		v_id = p_id;        
        
    elseif p_action = 'D' then
    
        if v_count = 0 then
			select fn_not_found(p_action, p_id) into v_msg;
        else    
			delete from tb_person where id = p_id;
        end if;    
        
		v_id = p_id;        

    end if;

    if trim(v_msg) = '' then
		select fn_success(p_action, v_id) into v_msg;
    end if;

	v_st = 1;
end
$$
