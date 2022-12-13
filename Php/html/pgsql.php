<?php

$host='kesavan.db.elephantsql.com';
$db = 'didkpepa';
$username = 'didkpepa';
$password = 'oavpNBSri87YlVUYzXMKUSkkhAktacSb';
$dsn = "pgsql:host=$host;port=5432;dbname=$db;user=$username;password=$password";

try {

    $conn = new PDO($dsn);
    if($conn) {
        echo "Connected to the <strong>$db</strong> database successfully!  </p></p></p>";
    }

    // use the connection here
    $stm = $conn->query('SELECT * FROM lancioni.tb_user');

    // fetch all rows into array, by default PDO::FETCH_BOTH is used
    $rows = $stm->fetchAll();

    // iterate over array by index and by name
    foreach($rows as $row) {
        printf("$row[0] $row[1] </p>");
    }

} 
catch (PDOException $e) {
  echo $e->getMessage();
}




?>