
SELECT
t1.table_name,
t2.column_name,
t2.data_type,
IFNULL(t2.character_maximum_length, 0) numeric_precision,
t2.is_nullable
FROM information_schema.tables t1
INNER JOIN information_schema.columns t2 ON
t1.table_name = t2.table_name and t1.table_schema = t2.table_schema
WHERE t1.table_schema = 'ecommerce'
AND t1.table_name = 'tb_person'
ORDER BY t2.ordinal_position
