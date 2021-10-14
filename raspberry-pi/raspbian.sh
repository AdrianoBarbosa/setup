#!/bin/bash

# consts
UBUNTU_VERSION=21.04
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echob() { echo -e "${BLUE}$1${NC}"; }
echog() { echo -e "${GREEN}$1${NC}"; }

GIT_USER_NAME='Adriano'
GIT_USER_EMAIL='change@me.com'

echog "updating"
sudo apt update &&
sudo apt upgrade -y

echog "install essentials"
sudo apt install tmux -y

echog "install and config git"
sudo apt install git -y &&
git config --global user.name $GIT_USER_NAME &&
git config --global user.email $GIT_USER_EMAIL

echog "install nodejs/nestjs"
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
sudo apt install nodejs -y
sudo npm i -g @nestjs/cli

echog "samba"
sudo apt install samba samba-common-bin
mkdir /home/pi/Shared

sudo echo [Shared] >> /etc/samba/smb.conf
sudo echo path = /home/pi/Shared >> /etc/samba/smb.conf
sudo echo writeable = yes >> /etc/samba/smb.conf
sudo echo public = yes >> /etc/samba/smb.conf

sudo smbpasswd -a $USER

echog "installing docker"
curl -fsSL https://get.docker.com -o get-docker.sh &&
sudo sh get-docker.sh &&
rm get-docker.sh &&
sudo usermod -aG docker $USER

echog "Done! 😎"

echo
echo "Press any key to reboot... "
read -rsn1
