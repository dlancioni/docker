<?php

$host='kesavan.db.elephantsql.com';
$db = 'didkpepa';
$username = 'didkpepa';
$password = 'oavpNBSri87YlVUYzXMKUSkkhAktacSb';
$dsn = "pgsql:host=$host;port=5432;dbname=$db;user=$username;password=$password";

try {

    $conn = new PDO($dsn);
    if($conn) {
        echo "Connected to the <strong>$db</strong> database successfully!";
    }
} 
catch (PDOException $e) {
  echo $e->getMessage();
}

?>