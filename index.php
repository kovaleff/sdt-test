<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$config = parse_ini_file('config.ini');
require_once 'db.php';


class TestCsv{
    private $config;
    private $db;

    function __construct($config)
    {
        $this->config = $config;
        $this->db = new DB($config);
    }

    function readFile(){
        $fp = fopen($this->config['csvFileName'], "r");
        $fpFailed = fopen($this->config['failedStringsFileNAme'], "a+");
        if($fp){
            while($data = fgetcsv($fp, 10000, ";")){
                $clientExists = $this->db->getById('clients', $data[0]);
                $merchandiseExists = $this->db->getById('merchandise', $data[1]);
                if((count($data)  !=3) OR  !$clientExists OR !$merchandiseExists){
                    fputs($fpFailed, implode(';',$data));
                    fputs($fpFailed, "\n");
                } else {
                    $this->db->putStringIntoTable('orders', [
                        'item_id' =>$data[0],
                        'customer_id' =>$data[1],
                        'comment' =>$data[2 ],
                        'order_date' => date('Y-m-d')
                    ]);
                }
            };
        } else {
            die('cant read file');
        }
    }
};

$test = new TestCsv($config);
$test->readFile();




