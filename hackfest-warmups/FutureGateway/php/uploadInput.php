<?php

$input_path_str = $argv[2];

$POST_DATA = array(
	 'file[]' => new \CurlFile(realpath($input_path_str), 'text/plain', $input_path_str)
);

$url_path_str = 'http://151.97.41.76:8888/v1.0/tasks/' . $argv[1] . '/input?user=gridct';
$ch = curl_init();

curl_setopt($ch, CURLOPT_URL, $url_path_str);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, $POST_DATA);
curl_setopt($ch, CURLOPT_SAFE_UPLOAD, 1);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$curl_response_res = curl_exec ($ch);
echo $curl_response_res;

?>
