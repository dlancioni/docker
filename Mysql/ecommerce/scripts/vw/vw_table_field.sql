/*
select * from vw_table_field
select * from vw_table_field where table_name = 'tb_person_type'
*/
USE ecommerce;
DROP VIEW IF EXISTS vw_table_field;
CREATE VIEW vw_table_field AS
SELECT 
t1.name table_name,
t2.name field_name,
t1.label table_label,
t2.label field_label
FROM tb_table t1
INNER JOIN tb_table_field t2 ON t1.id = t2.table_id
	
    
