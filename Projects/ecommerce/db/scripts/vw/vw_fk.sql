USE ecommerce;

drop view if exists vw_fk;
create view vw_fk as
select distinct
t2.constraint_type,
t1.constraint_name,
t1.table_schema, 
t1.table_name,
t1.column_name,
t1.referenced_table_schema, 
t1.referenced_table_name, 
t1.referenced_column_name
from information_schema.key_column_usage t1
inner join information_schema.table_constraints t2 on t1.table_schema = t2.table_schema and t1.table_name = t2.table_name 
inner join information_schema.referential_constraints t3 on  t1.constraint_name = t3.constraint_name
-- where t2.constraint_type = 'FOREIGN KEY'