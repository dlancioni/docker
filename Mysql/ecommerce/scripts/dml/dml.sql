use ecommerce;

-- tb_table_field
delete from tb_message;
insert into tb_message values (1, 'Ação inválida, deve ser [I]nsert, [U]pdate, [D]elete ou [S]elect');
insert into tb_message values (2, 'Campo Id é obrigatório na alteração ou exclusão de registros');
insert into tb_message values (3, 'Valor informado para o campo %1 não existe no cadastro de %2');
insert into tb_message values (4, 'Campo %1 é obrigatório');
insert into tb_message values (5, 'Não foi possível excluir os registros, existem registros relacionados no cadastro de %1');
insert into tb_message values (6, 'Registro incluído com sucesso');
insert into tb_message values (7, 'Registro alterado com sucesso');
insert into tb_message values (8, 'Registro excluído com sucesso');

-- tb_table_field
delete from tb_table_field;
insert into tb_table_field (table_name, field_name, table_label, field_label) values ('tb_person', 'id', 'Pessoas', 'Id');
insert into tb_table_field (table_name, field_name, table_label, field_label) values ('tb_person', 'name', 'Pessoas', 'Nome');
insert into tb_table_field (table_name, field_name, table_label, field_label) values ('tb_person_type', 'id', 'Tipo de Pessoas', 'Id');
insert into tb_table_field (table_name, field_name, table_label, field_label) values ('tb_person_type', 'name', 'Tipo de Pessoas', 'Nome');
insert into tb_table_field (table_name, field_name, table_label, field_label) values ('tb_person_classification', 'id', 'Classificação de Pessoas', 'Id');
insert into tb_table_field (table_name, field_name, table_label, field_label) values ('tb_person_classification', 'name', 'Classificação de Pessoas', 'Nome');

-- tb_person_type
delete from tb_person_type;
insert into tb_person_type (id, ds) values (1, 'Pessoa Física');
insert into tb_person_type (id, ds) values (2, 'Pessoa Jurídica');

-- tb_person_classification
delete from tb_person_classification;
insert into tb_person_classification (id, ds) values (1, 'Cliente');
insert into tb_person_classification (id, ds) values (2, 'Fornecedor');
insert into tb_person_classification (id, ds) values (3, 'Funcionário');



