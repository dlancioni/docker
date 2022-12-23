/*
select * from vw_table_field
where table_name = 'tb_person' 
and field_name = 'birth'
*/
drop view if exists vw_table_field;
create or replace view vw_table_field as
select
t.name table_name,
f.name field_name,
t.label table_label,
f.label field_label
from tb_table t
inner join tb_field f on t.id = f.table_id
order by t.id, f.id