<?php

function connect()
{
    $servername = "db";
    $username = "root";
    $password = "admin";
    $dbname = "ecommerce";

    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    return $conn;
}

function query($conn, $sql)
{
    $result = $conn->query($sql);
    return $result;
}


$conn = connect();
$result = query($conn, "select * from tb_person_type");

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
      echo "id: " . $row["id"]. " - Ds: " . $row["ds"] . "<br>";
    }
  }

$conn->close();

?>