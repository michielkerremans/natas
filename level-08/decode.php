<?php
echo base64_decode(strrev(hex2bin($argv[1]))) . "\n";
