#!/bin/bash

# Files permissions
sudo chmod 644 check-openvpn-status.sh
sudo chmod 644 delete-wget-files.sh

# Check openvpn status script
(
    crontab -l
    echo "*/1 * * * * /home/pi/scripts/openvpn/check-openvpn-status.sh"
) | sort - | uniq - | crontab -

# Delete temp files script
(
    crontab -l
    echo "* 6 * * *  /home/pi/scritps/openvpn/delete-wget-files.sh"
) | sort - | uniq - | crontab -

# Restart Pi Device
(
    crontab -l
    echo "* 6 * * *  sudo shutdown -r now >/dev/null 2>&1"
) | sort - | uniq - | crontab -
