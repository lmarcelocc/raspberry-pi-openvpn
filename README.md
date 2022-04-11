# OpenVPN check connection

Script to test an OPENVPN connection on a Raspberry Pi Device

# Requirements

- Git: `sudo apt-get install git`

# Installation

- Go to `/home/pi/scripts/` and clone the project with the following command:
  `git clone https://github.com/lmarcelocc/openvpn.git`
- Update `./start.sh` file permissions to allow them to be executed: `sudo chmod 644 start.sh`
- Run update-crontab.sh with following command `./start.sh`

# Update

To update just run `git pull` at `/home/pi/scripts/openvpn`
