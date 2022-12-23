--
-- Catalog
--
drop view if exists vw_table_field;

drop table if exists tb_field;
create table tb_field
(
    id serial,
    table_id int not null,
    name text not null,
    label text not null
);

drop table if exists tb_table;
create table tb_table
(
    id serial,
    name text not null,
    label text not null
);

--
-- Messages
--
drop table if exists tb_message;
create table tb_message 
(
    id serial,
    message varchar(500) not null
);

--
-- Model
--
drop table if exists tb_document;
create table tb_document 
(
    id serial,
    name text not null
);

drop table if exists tb_person_document;
create table tb_person_document 
(
    id serial,
    person_id int not null,
    document_id int not null,
    number text not null
);

drop table if exists tb_person_classification;
create table tb_person_classification
(
    id serial,
    ds varchar(50)
);

drop table if exists tb_person_type;
create table tb_person_type
(
    id serial,
    ds varchar(50)
);

drop table if exists tb_person;
create table tb_person
(
    id serial,
    classification_id int,
    type_id int,
    name varchar(50),
    birth date
);

