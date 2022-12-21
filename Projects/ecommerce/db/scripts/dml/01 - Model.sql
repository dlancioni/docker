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