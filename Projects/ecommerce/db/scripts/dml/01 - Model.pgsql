drop table if exists tb_person;
create table tb_person
(
    id serial,
    classification_id int,
    type_id int,
    name varchar(50),
    birth date
);

drop table if exists tb_person_type;
create table tb_person_type
(
    id serial,
    ds varchar(50)
);