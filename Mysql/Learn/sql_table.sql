
SELECT DISTINCT
t2.ORDINAL_POSITION,
t1.TABLE_NAME,
t2.COLUMN_NAME,
t2.DATA_TYPE,
IFNULL(t2.CHARACTER_MAXIMUM_LENGTH, 0) NUMERIC_PRECISION,
t2.IS_NULLABLE
FROM INFORMATION_SCHEMA.TABLES t1
INNER JOIN INFORMATION_SCHEMA.COLUMNS t2 on 
	t1.TABLE_NAME = t2.TABLE_NAME AND t1.TABLE_SCHEMA = t2.TABLE_SCHEMA
WHERE t1.table_schema = 'person'
AND t1.table_name LIKE 'tb_person'
ORDER BY t2.ORDINAL_POSITION
