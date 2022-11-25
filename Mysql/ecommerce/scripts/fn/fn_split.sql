/*
SELECT SPLIT("1, 'David Lancioni', 100.22 ", ',', 3) as third;
*/
DROP FUNCTION IF EXISTS fn_split;
CREATE FUNCTION fn_split(
  x VARCHAR(255),
  delim VARCHAR(12),
  pos INT
)
RETURNS VARCHAR(255)
DETERMINISTIC
RETURN TRIM(REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
       LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
       delim, ''));
       
       
