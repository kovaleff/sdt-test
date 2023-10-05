<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$config = parse_ini_file('config.ini');
require_once 'db.php';
$db = new DB($config);
$clients = [
    'Client1',
    'Client2',
    'Client3',
    'Client4',
    'Client5',
];

$merchandises = [
    'Merchandise1',
    'Merchandise2',
    'Merchandise3',
    'Merchandise4',
    'Merchandise5',
];
function seedClients($db,$clients){
    foreach ($clients as $client){
        $db->addNameRowIntoTable('clients', $client);
    }
}
function seedMerchandises($db,$merchandises)
{
    foreach ($merchandises as $merchandise) {
        $db->addNameRowIntoTable('merchandise', $merchandise);
    }
}

function seedOrders($db, $clients, $merchandises){
    foreach (range(0, 100) as $index) {
        $client = $clients[array_rand($clients)];
        $merchandise = $merchandises[array_rand($merchandises)];
        $order_date = date('Y-m-d', strtotime('2020-12-08 04:16:51 +'.rand(30, 60 * 60 * 24 * 3).' seconds'));
        $status = ['new','complete'][rand(0,1)];
        $comment = 'comment:'.rand(0,1000);
        $item_id = $db->getIdByName('clients', $client);
        $customer_id = $db->getIdByName('merchandise', $merchandise);
        $db->putStringIntoTable('orders',[
            'item_id' => $item_id,
            'customer_id' => $customer_id,
            'comment' => $comment,
            'status' => $status,
            'order_date' => $order_date
        ]);
    }
}
seedOrders($db, $clients, $merchandises);

