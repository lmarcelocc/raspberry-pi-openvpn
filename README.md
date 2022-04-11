# OpenVPN check connection

Script to test an OPENVPN connection on a Raspberry Pi Device

# Requirements

- Git: `sudo apt-get install git`

# Installation

- Go to `/home/pi/scripts/` and clone the project with the following command:
  `git clone https://github.com/lmarcelocc/raspberry-pi-openvpn.git openvpn`
- Update file permission to allow it to be executed: `sudo chmod 755 start.sh`
- Run update-crontab.sh with following command `./start.sh`

# Telegram

If you want to receive notifications each time this script will try to restart your openvnp service, you can do so, following the next steps:

- Run `cp telegram.example.sh telegram.sh`
- Run `nano telegram.sh` and update at least telegramBotToken, telegramChatId and myUser. You've a default essage but you can change it to your needs.

# Update

To update just run `git pull` at `/home/pi/scripts/openvpn`

# Uninstall

- Just be sure to remove the job from crontab.
