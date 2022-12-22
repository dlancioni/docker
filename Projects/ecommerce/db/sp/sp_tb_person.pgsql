/*
delete from tb_person
select * from tb_person
select * from tb_person_type
select * from tb_person_classification

do
$$
declare
	o_st int default 0;
	o_msg text default '';
	o_id int default 0;
begin
    -- call sp_tb_person(99, 1, 0, 1, 1, 'Name 1', '2022-12-31', o_st, o_msg, o_id);
	-- call sp_tb_person(99, 2, 1, 1, 1, 'David Lancioni', '1979-02-15', o_st, o_msg, o_id);
	   call sp_tb_person(99, 3, 2, 1, 1, 'David Lancioni', '1979-02-15', o_st, o_msg, o_id);
    raise notice 'Status: %', o_st;
end
$$;

*/

create or replace procedure sp_tb_person
(
	p_user int,
	p_action int,
	p_output out output,
	p_id int,
	p_type_id int,
	p_classification_id int,
    p_name text,
	p_birth date
)
language plpgsql
as
$$

declare
    v_count int default 0;

begin

	-- Initialize status
	p_output = '0|0|msg';

    -- Valid action
    select fn_validate_action(p_action) into o_msg;
	if o_msg <> '' then
		return; 
	end if;

    -- Mandatory fields
    select fn_validate_mandatory(p_action, p_name, 'tb_person', 'name') into o_msg;
	if o_msg <> '' then 
		return; 
	end if;

	-- Validate fk
    select count(id) into v_count from tb_person_type where id = p_type_id;
    select fn_validate_fk(p_action, v_count, 'tb_person', 'type_id', 'tb_person_type', 'id') into o_msg;
	if o_msg <> '' then 
		return;
	end if;

	select count(id) into v_count from tb_person where id = p_id;

    if p_action = 1 then

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
		returning id into o_id;

    elseif p_action = 2 then

        if v_count = 0 then
			select fn_not_found(p_action, p_id) into o_msg;
        else
			update tb_person set
				classification_id = p_classification_id,
				type_id = p_type_id,
				name = p_name,
				birth = p_birth
			where id = p_id;           
        end if;
        
		o_id = p_id;        
        
    elseif p_action = 3 then
    
        if v_count = 0 then
			select fn_not_found(p_action, p_id) into o_msg;
        else    
			delete from tb_person where id = p_id;
        end if;    
        
		o_id = p_id;        

    end if;

    if trim(o_msg) = '' then
		select fn_success(p_action, o_id) into o_msg;
    end if;

	o_st = 1;
end
$$
