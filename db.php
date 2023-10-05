<?php

class DB{
    public static $conn = null;
    public function __construct($config)
    {
        if(!self::$conn){
            try {
                $dsn =  "mysql:host={$config['dbhost']};dbname={$config['dbtable']}";
                self::$conn = new PDO($dsn,$config['dbuser'], $config['dbpass'], [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
            } catch(PDOException $e) {
                echo "Connection failed: "
                    . $e->getMessage();
            }
        }
    }

    function getById($table, $id){
        $q = self::$conn->prepare("SELECT * FROM $table WHERE id=?");
        $q->execute([$id]);
        return $q->fetch();
    }
    function getIdByName($table, $name){
        $q = self::$conn->prepare("SELECT id FROM $table WHERE name=?");
        $q->execute([$name]);
        return $q->fetchColumn();
    }
    function putStringIntoTable($table, $data){
        $size = count($data);
        $paramsStr = trim(str_repeat('?,',$size),',');
        $keysStr = implode(',',array_keys($data));
        $valuseStr = implode(',', array_values($data));
        $values = array_values($data);
        $sql = "INSERT INTO $table ($keysStr) VALUES ($paramsStr)";
        $q = self::$conn->prepare($sql)->execute($values);
    }

    function addNameRowIntoTable($table, $value){
        $q = self::$conn->prepare("INSERT INTO $table (name) VALUES ('$value')")->execute();
    }

//    function putRowInOrdersTable($data){
//        $q = self::$conn->prepare("'INSERT INTO orders(item_id,customer_id,comment) VALUES(:item_id,:customer_id,:comment)'");
//        $q->execute([
//            'item_id'=> $data[0],
//            'customer_id'=> $data[1],
//            'comment'=> $data[2]
//        ]);
//    }
}

