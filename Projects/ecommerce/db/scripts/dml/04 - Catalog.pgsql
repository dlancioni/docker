/*
select * from vw_table_field
select * from tb_table
select * from tb_field
*/

drop view vw_table_field;

drop table if exists tb_table;
create table tb_table
(
    id serial,
    name text not null,
    label text not null
);

drop table if exists tb_field;
create table tb_field
(
    id serial,
    table_id int not null,
    name text not null,
    label text not null
);

-- tb_person_type
set app.id = 1;
insert into tb_table (id, name, label) values (current_setting('app.id')::int, 'tb_person_type', 'Tipo de Pessoa');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'id', 'Id');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'ds', 'Descrição');

-- tb_person_classification
set app.id = 2;
insert into tb_table (id, name, label) values (current_setting('app.id')::int, 'tb_person_classification', 'Classificação de Pessoa');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'id', 'Id');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'ds', 'Descrição');

-- tb_person
set app.id = 3;
insert into tb_table (id, name, label) values (current_setting('app.id')::int, 'tb_person', 'Pessoas');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'id', 'Id');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'type_id', 'Tipo de Pessoa');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'classification_id', 'Classificação de Pessoa');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'name', 'Nome');
insert into tb_field (table_id, name, label) values (current_setting('app.id')::int, 'birth', 'Data de Nascimento');
