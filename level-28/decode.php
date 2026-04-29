<?php
$query = isset($argv[1]) ? $argv[1] : "";
$cipher = base64_decode(urldecode($query));

echo strlen($cipher) . " bytes\n";

$blocks = str_split($cipher, 16);
foreach ($blocks as $i => $block) {
  echo "Block $i: " . bin2hex($block) . "\n";
}
