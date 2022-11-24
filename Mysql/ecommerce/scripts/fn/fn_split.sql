/*
SELECT SPLIT("1, 'David Lancioni', 100.22", ',', 3) as third;
*/

CREATE FUNCTION fn_split(
  x VARCHAR(255),
  delim VARCHAR(12),
  pos INT
)
RETURNS VARCHAR(255)
DETERMINISTIC
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
       LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
       delim, '');
       
       
