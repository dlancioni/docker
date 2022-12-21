/*
select * from vw_table_field
*/

use ecommerce;
set foreign_key_checks = 0;

-- clean up
truncate table tb_field;
truncate table tb_table;

-- tb_person_type
set @id = 1;
insert into tb_table (id, name, label) values (@id, 'tb_person_type', 'Tipo de Pessoa');
insert into tb_field (table_id, name, label) values (@id, 'id', 'Id');
insert into tb_field (table_id, name, label) values (@id, 'ds', 'Descrição');

-- tb_person_classification
set @id = 2;
insert into tb_table (id, name, label) values (@id, 'tb_person_classification', 'Classificação de Pessoa');
insert into tb_field (table_id, name, label) values (@id, 'id', 'Id');
insert into tb_field (table_id, name, label) values (@id, 'ds', 'Descrição');

-- tb_person
set @id = 3;
insert into tb_table (id, name, label) values (@id, 'tb_person', 'Pessoas');
insert into tb_field (table_id, name, label) values (@id, 'id', 'Id');
insert into tb_field (table_id, name, label) values (@id, 'type_id', 'Tipo de Pessoa');
insert into tb_field (table_id, name, label) values (@id, 'classification_id', 'Classificação de Pessoa');
insert into tb_field (table_id, name, label) values (@id, 'name', 'Nome');
insert into tb_field (table_id, name, label) values (@id, 'birth', 'Data de Nascimento');

-- finish
set foreign_key_checks = 1;