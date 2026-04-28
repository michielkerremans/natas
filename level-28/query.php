<?php

if (!isset($argv[1])) {
  echo "Usage: php query.php <input>\n";
  exit(1);
}

$input = $argv[1];

$output = shell_exec(
  'curl -s -L -D - -o /dev/null -u natas28:1JNwQM1Oi6J6j1k49Xyw7ZN6pXMQInVj ' .
    '-d "query=' . $input . '" ' .
    'http://natas28.natas.labs.overthewire.org/index.php'
);

preg_match('/Location:\s*.*query=([^\s]+)/i', $output, $m);

echo "$m[1]" . PHP_EOL;
