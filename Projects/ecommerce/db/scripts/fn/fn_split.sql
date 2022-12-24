/*
select fn_split("1, 'david lancioni', 100.22 ", ',', 3);
*/
drop function if exists fn_split;

create function fn_split
(
  x varchar(255),
  delim varchar(12),
  pos int
)
returns varchar(255)
deterministic
return trim(replace(substring(substring_index(x, delim, pos), length(substring_index(x, delim, pos -1)) + 1), delim, ''));