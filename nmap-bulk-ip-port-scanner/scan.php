<?php
require 'vendor/autoload.php';
use Nmap\Nmap;

$file = fopen("ip_list.txt","r");

while(! feof($file)) {


    $hosts = Nmap::create()->scan([trim(fgets($file))], [25001, 37777, 8000]); // Nmap::create()->scan(@IP_ADDRESS,@PORTS(optional))
    foreach ($hosts as $host) {
        $ports = $host->getOpenPorts();
        $flag = true;

        foreach ($ports as $port) {
            if ($port->getNumber() == 25001 || $port->getNumber() == 37777 || $port->getNumber() == 8000) {
                $flag = false;
            }
        }
        if ($flag) {
            echo "NO: " . $host->getAddress();
        } else {
            echo "YES: " . $host->getAddress();
            file_put_contents("list.txt", $host->getAddress() . "\n", FILE_APPEND);
        }
        echo "\n";
    }
}