<?php

function connect()
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

function query($conn, $sql)
{
    $result = $conn->query($sql);

    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            echo "id: " . $row["id"]. " - Ds: " . $row["ds"] . "<br>";
        }
    }
    
}

function execute($conn, $sql)
{
    //$stmt = $conn->prepare($sql);
    //$stmt->bind_param("is", $id, $output);
    //$stmt->execute();

    $conn->multi_query( "CALL sp_test(1, @output);select @output as output" );
    $conn->next_result();
    $rs=$conn->store_result();
    echo $rs->fetch_object()->output, "\n";
    $rs->free();


}

$conn = connect();
// query($conn, "select * from tb_person_type");
execute($conn, "CALL sp_test(?, ?)");
$conn->close();

?>