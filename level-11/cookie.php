<?php

if ($argc < 2) {
  die("Usage: php {$argv[0]} COOKIE_VALUE\n");
}

$default_cookie = $argv[1];

$known_plaintext = json_encode([
  "showpassword" => "no",
  "bgcolor" => "#ffffff"
]);

# XOR is symmetric
# plaintext XOR key = ciphertext
# ciphertext XOR key = plaintext

# Why?
# b ^ 1 = ~b and b ^ ~b = 1
# b ^ 0 = b and b ^ b = 0
# b ^ k = c and c ^ k = b

function xor_encrypt($data, $key)
{
  $out = '';
  for ($i = 0; $i < strlen($data); $i++) {
    $out .= $data[$i] ^ $key[$i % strlen($key)];
    # $key[$i % strlen($key)] : repeats the key if it's shorter than the data!
  }
  return $out;
}

$cipher = base64_decode($default_cookie);

$key_stream = '';

for ($i = 0; $i < strlen($cipher); $i++) {
  $key_stream .= $cipher[$i] ^ $known_plaintext[$i % strlen($known_plaintext)];
}

echo "Recovered keystream: " . $key_stream . "\n";

echo "Enter key length: ";
$key_length = intval(trim(fgets(STDIN)));
$key = substr($key_stream, 0, $key_length);
echo "\nRecovered key: $key\n\n";

$new_plaintext = json_encode([
  "showpassword" => "yes",
  "bgcolor" => "#ffffff"
]);

$new_cipher = xor_encrypt($new_plaintext, $key);
$new_cookie = base64_encode($new_cipher);
echo "New cookie value: $new_cookie\n";
