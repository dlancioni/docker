/*
delete from tb_person
select * from tb_person
select * from tb_person_classification

call sp_tb_person('I', null, 1, 1, 'Name 1', '2022-12-31', @v_st, @v_msg);
select @v_st, @v_msg

call sp_tb_person('U', 1, 3, 3, 'David Lancioni', '1979-02-15', @v_st, @v_msg);
select @v_st, @v_msg

call sp_tb_person('D', 36, null, null, null, null, @v_st, @v_msg);
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

	if p_action = 'U' or p_action = 'D' then
    
		if p_id is null or p_id = 0 then        
			set v_msg = 'Campo Id é obrigatório na alteração ou exclusão de registros';
			leave sp;
		end if;
        
        select count(id) into v_count from tb_person where id = p_id;        
		if v_count = 0 then
            set v_msg = concat('Valor informado para o campo [TB_PERSON.ID] não existe no cadastro de [TB_PERSON]');
			leave sp;
		end if;
        
    end if;
    
	if p_action = 'I' or p_action = 'U' then   
    
		if p_type_id is null or p_type_id = 0 then
   		    set v_msg = 'Campo Id é obrigatório';
			leave sp;
		end if;
        
        select count(id) into v_count from tb_person_type where id = p_type_id;
		if v_count = 0 then
  			set v_msg = concat('Valor informado para o campo [TB_PERSON.TYPE_ID] não existe no cadastro de [TB_PERSON_TYPE]');
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
		set v_msg = 'Registro incluído com sucesso';

    elseif p_action = "U" then

		update tb_person set
			classification_id = p_classification_id,
			type_id = p_type_id,
			name = p_name,
			birth = p_birth
		where id = p_id;        
		set v_msg = 'Registro alterado com sucesso';
        
    elseif p_action = "D" then

		delete from tb_person where id = p_id;       
		set v_msg = 'Registro excluído com sucesso';

    end if;

	set v_st = 1;
end
$$
