<?php

function db_open()
{
    $server = "db";
    $port = "5432";
    $db = "postgres";
    $user = "postgres";
    $pwd = "admin";    
    $conn = pg_connect("host=$server port=$port dbname=$db user=$user password=$pwd");
    return $conn;
}

function db_close($conn)
{
    pg_close($conn);
}

function db_query($conn, $sql)
{
    return pg_query($conn, $sql);
}

function db_execute($conn, $sql, $values)
{
    $total = 5;
    $result = [];
    $result = pg_query_params($conn, $sql, $values);
    $result = pg_fetch_row($result);
    $result = $result[0];
    $result = str_replace("(", "", $result);
    $result = str_replace(")", "", $result);
    $result = str_replace('"', "", $result, $total);
    $result = explode(",", $result);
    return $result;
}

function test_query()
{
    $conn = db_open();
    $rs = db_query($conn, "select * from tb_person_type");
    while($row = pg_fetch_array($rs)) {
        echo "id: " . $row["id"]. " - Ds: " . $row["ds"] . "<br>";
    }
    db_open($conn);
}

function test_execute()
{
    $cmd = "call sp_1($1)";
    $data = Array("(0,0,'')");
    $conn = db_open();
    $rs = db_execute($conn, $cmd, $data);
    echo $rs[0];
    echo $rs[1];
    echo $rs[2];
    db_open($conn);
}

test_execute();

?>