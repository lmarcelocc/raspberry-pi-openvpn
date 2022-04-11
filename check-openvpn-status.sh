#!/bin/bash

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
            logger "MARCELO_VPN: NOT VALID IP. Retrying: $I"
            echo "NOT VALID IP. Retrying: $I"
            sleep 2
            continue
        else
            break
        fi
    done

    if [[ ! $result =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        sudo systemctl restart openvpn
        wget https://api.telegram.org/bot5009602069:AAGc3va6eQKRpB0ypcgNHkTCegBbCS2tB1o/sendMessage?chat_id=-605253269"&"text=OPENVPN_WAS_DOWN_TRYING_TO_RESTART_MARCELO
    fi
fi

if [[ $ping_results -eq 0 ]]; then
    echo "All fine with openvpn service."
elif [[ $ping_results -ne 0 ]]; then
    echo "openvpn service seems down...trying to restart it."
    logger "MARCELO: tun0 SEEMS TO BE DOWN: $ping_results"
    sudo systemctl restart openvpn
    wget https://api.telegram.org/bot5009602069:AAGc3va6eQKRpB0ypcgNHkTCegBbCS2tB1o/sendMessage?chat_id=-605253269"&"text=OPENVPN_WAS_DOWN_TRYING_TO_RESTART_MARCELO
fi
