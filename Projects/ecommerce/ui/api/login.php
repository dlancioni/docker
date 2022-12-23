<?php

//echo '{"name":"John","age":30,"city":"New York"}';
// echo '{"name":"David Lancioni"}';

$name = $_REQUEST["username"];

$a = array('name'=>$name);

$b = json_encode($a);

echo $b;

?>