USE ecommerce;

drop view if exists vw_catalog;
create view vw_catalog as
select
t1.table_name table_name,
t2.column_name field_name,
t2.data_type field_type,
ifnull(t2.character_maximum_length, 0) field_size,
lower(t2.is_nullable) field_nullable
from information_schema.tables t1
inner join information_schema.columns t2 on
t1.table_name = t2.table_name and t1.table_schema = t2.table_schema
where t1.table_schema = 'ecommerce'
order by t2.ordinal_position