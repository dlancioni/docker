<?php

function db_open()
{
    $servername = "db";
    $username = "root";
    $password = "admin";
    $dbname = "ecommerce";

    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    return $conn;
}

function db_close($conn)
{
    $conn->close();
}    

function db_execute($conn, $sql)
{
    return $conn->query($sql);
}


function test($conn, $sql)
{
    $result = db_execute($conn, $sql);

    if ($result->num_rows > 0)
    {
        while( $row = $result->fetch_assoc() )
        {
            echo " Status: " . $row["status"] . "<br> Message: " . $row["message"] . "<br> Id: " . $row["id"];
        }
    }
}

$conn = db_open();
//test($conn, "call sp_test(1)");
test($conn, "select 1 status, 'Ola' message, 99 id");
db_close($conn);

?>