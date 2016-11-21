<?php


$url_path_str = 'http://151.97.41.76:8888/v1.0/tasks/'. $argv[1];
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, ''.$url_path_str.'');
$curl_response_res = curl_exec ($ch);
echo $curl_response_res;
?>
