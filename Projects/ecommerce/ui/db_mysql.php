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
    $statement = "call $sql; select @output as output;";

    $conn->multi_query( $statement );

    do 
    {

      if ($result = $conn->store_result()) 
      {
          while ($row = $result->fetch_row()) 
          {
              printf("%s\n", $row[0]);
          }
      }

      if ($conn->more_results()) 
      {
          printf("-----------------<br>");
      }

  } while ($conn->next_result());
  

}

$conn = connect();
// query($conn, "select * from tb_person_type");
execute($conn, "sp_test(1, @output)");
$conn->close();

?>