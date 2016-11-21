<?php

$data = fopen($argv[1]."_sayhello.data", "w");
$stdout = fopen($argv[1]."_stdout", "w");
$stderr = fopen($argv[1]."_stderr", "w");
$url_path_str = 'http://151.97.41.76:8888/v1.0/'. $argv[2];
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, ''.$url_path_str.'');
curl_setopt($ch, CURLOPT_HEADER, 0);
curl_setopt($ch, CURLOPT_BINARYTRANSFER,1);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
$curl_response_res = curl_exec ($ch);
curl_close ($ch);

fwrite($data, $curl_response_res);
fclose($data);

$url_path_str = 'http://151.97.41.76:8888/v1.0/'. $argv[3];
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, ''.$url_path_str.'');
curl_setopt($ch, CURLOPT_HEADER, 0);
curl_setopt($ch, CURLOPT_BINARYTRANSFER,0);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
$curl_response_res = curl_exec ($ch);
curl_close ($ch);

fwrite($stdout, $curl_response_res);
fclose($stdout);

$url_path_str = 'http://151.97.41.76:8888/v1.0/'. $argv[4];
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, ''.$url_path_str.'');
curl_setopt($ch, CURLOPT_HEADER, 0);
curl_setopt($ch, CURLOPT_BINARYTRANSFER,0);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
$curl_response_res = curl_exec ($ch);
curl_close ($ch);

fwrite($stderr, $curl_response_res);
fclose($stderr);

?>
