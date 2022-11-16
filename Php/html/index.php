<?php
$conn = new mysqli("20fade5e5888","root","admin","db1");

// Check connection
if ($mysqli -> connect_errno) {
  echo "Failed to connect to MySQL: " . $mysqli -> connect_error;
  exit();
}

$sql = "SELECT 1+1 total";
$result = $conn->query($sql);

if ($result->num_rows > 0) {

    while($row = $result->fetch_assoc()) {
      echo "id: " . $row["total"] ;
    }
  } else {
    echo "0 results";
  }
  $conn->close();

?>
