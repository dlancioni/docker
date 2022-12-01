SET @mapJSON = '[ {"id":12, "qtt":1, "vl":10.0},{"id":15, "qtt":5, "vl":1.99}]';

SET @key1 = "$[0].qtt";
SET @key2 = "$[1].qtt";

SELECT JSON_EXTRACT(@mapJSON, @key1) AS 'from',
         JSON_EXTRACT(@mapJSON, @key2) AS 'to' ;