<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>Untitled Document</title>
</head>

<body>

<?php
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL,"https://api.nutritionix.com/v1_1/item");
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS,
        "upc=52200004265&appId=e394378b&appKey=38bff1a7253f76890ab0df76beaf7fdb");

curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

$response = curl_exec ($ch);

curl_close ($ch);

print_r($response);
?>

</body>
</html>