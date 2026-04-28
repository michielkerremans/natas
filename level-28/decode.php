<?php

$query = trim(file_get_contents("php://stdin"));
$cipher = base64_decode(urldecode($query));
$blocks = str_split($cipher, 16);

echo strlen($cipher) . " bytes: ";
foreach ($blocks as $b) {
  echo base64_encode($b) . "  ";
}
echo PHP_EOL;
