# OpenVPN check connection

Script to test an OPENVPN connection on a Raspberry Pi Device. It will check, periodically, if the tun0 exists and if it can get an valid IP address.

If you have more tunnels or different names, be sure to fork this proejct and update the script to your needs.

# Requirements

- Git: `sudo apt-get install git` on your Raspberry Pi Device.

# Installation

- Create a folder, at your home, named `scripts` with: `mkdir /home/pi/scripts/`
- Go to `/home/pi/scripts/` and clone the project with the following command:
  `git clone https://github.com/lmarcelocc/raspberry-pi-openvpn.git openvpn`
- Go into the cloned folder `cd openvpn`
- Update file permission to allow it to be executed: `sudo chmod 755 start.sh`
- Run start.sh script with following command `./start.sh`

# Telegram

If you want to receive notifications each time this script will try to restart your openvnp service, you can do so, following the next steps:

- Run `cp telegram.example.sh telegram.sh`
- Run `nano telegram.sh` and update at least telegramBotToken, telegramChatId and myUser. You've a default essage but you can change it to your needs.

# Update

To update this script just run `git pull` at `/home/pi/scripts/openvpn`

# Uninstall

- Just be sure to remove the job from crontab.
