<?php

$json = '{
    "application":"2",
    "description":"sayhello@csgfsdk test run", 
    "input_files": [{
        "name":"sayhello.sh"
    },
    {
        "name":"sayhello.txt"
    }],
    "arguments": ["\"I am saying hello!\""],
    "output_files": [{
       "name":"sayhello.data"
    }]
}';


$url_path_str = 'http://151.97.41.76:8888/v1.0/tasks?user=gridct';
$headers = [
    'Content-Type: application/json'
];
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, ''.$url_path_str.'');
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
curl_setopt($ch, CURLOPT_POSTFIELDS, $json);
$curl_response_res = curl_exec ($ch);
echo $curl_response_res;
?>
