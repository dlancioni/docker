--
-- Messages
--
delete from tb_message;
insert into tb_message values (1, 'Ação inválida, deve ser [1] Inclusão, [2] Alteração, [3] Exclusão');
insert into tb_message values (2, 'Campo Id é obrigatório na alteração ou exclusão de registros');
insert into tb_message values (3, 'Valor informado para o campo %1 não existe no cadastro de %2');
insert into tb_message values (4, 'Campo %1 é obrigatório');
insert into tb_message values (5, 'Não foi possível excluir os registros, existem registros relacionados no cadastro de %1');
insert into tb_message values (6, 'Registro informado (%1) não encontrado para %2');
insert into tb_message values (10, 'Registro (%1) incluído com sucesso');
insert into tb_message values (11, 'Registro (%1) alterado com sucesso');
insert into tb_message values (12, 'Registro (%1) excluído com sucesso');
--
-- Model
--
delete from tb_person_type;
insert into tb_person_type (id, ds) values (1, 'Pessoa Física');
insert into tb_person_type (id, ds) values (2, 'Pessoa Jurídica');

delete from tb_person_classification;
insert into tb_person_classification (id, ds) values (1, 'Cliente');
insert into tb_person_classification (id, ds) values (2, 'Fornecedor');
insert into tb_person_classification (id, ds) values (3, 'Funcionário');
--
-- Catalog
--
set app.id = 1;
insert into tb_table (id, name, label) values (current_setting('app.id')::int, 'tb_person_type', 'Tipo de Pessoa');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'id', 'Id');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'ds', 'Descrição');
set app.id = 2;
insert into tb_table (id, name, label) values (current_setting('app.id')::int, 'tb_person_classification', 'Classificação de Pessoa');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'id', 'Id');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'ds', 'Descrição');
set app.id = 3;
insert into tb_table (id, name, label) values (current_setting('app.id')::int, 'tb_person', 'Pessoas');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'id', 'Id');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'type_id', 'Tipo de Pessoa');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'classification_id', 'Classificação de Pessoa');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'name', 'Nome');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'birth', 'Data de Nascimento');



