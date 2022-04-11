#!/bin/bash

TELEGRAM_FILE=./telegram.sh

function call_telegram {
    if [ -f "$TELEGRAM_FILE" ]; then
        source ./telegram.sh
    fi
}

# zero means no error, 1 means error
ping_results=$(
    ip link show dev tun0 >/dev/null
    echo $?
)
result=$(wget http://ipinfo.io/ip --timeout=4 --tries=20 -qO -)
echo $result
echo "zero means OK: ${ping_results}"
if [[ $result =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "WGET returned a valid IP"
else
    # If it fails getting IP
    # Before retrying first time, wait at least 2 seconds
    sleep 2

    # Retry 5 times with 2 seconds (sleep 2) interval
    for I in 1 2 3 4 5; do
        result=$(wget http://ipinfo.io/ip --timeout=4 --tries=20 -qO -)
        if [[ ! $result ]]; then
            logger "OPENVPN_SCRIPT: NOT VALID IP. Retrying: $I"
            echo "NOT VALID IP. Retrying: $I"
            sleep 2
            continue
        else
            break
        fi
    done

    if [[ ! $result =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        sudo systemctl restart openvpn
        call_telegram
    fi
fi

if [[ $ping_results -eq 0 ]]; then
    echo "All fine with openvpn service."
elif [[ $ping_results -ne 0 ]]; then
    echo "openvpn service seems down...trying to restart it."
    logger "OPENVPN_SCRIPT: tun0 SEEMS TO BE DOWN: $ping_results"
    sudo systemctl restart openvpn
    call_telegram
fi
