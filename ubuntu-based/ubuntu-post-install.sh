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

# action!
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
echog "first and most important... a dark theme"

echog "customizing ubuntu dock"
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false

echog "to solve problems with time in dual boot Ubuntu/Windows"
timedatectl set-local-rtc true

echob "################################################################################"
echob "#"
echob "# Repositories"
echob "#"
sudo apt update
echog "curl"
sudo apt install curl -y

echog "vscode"
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

echog "dotnet"
wget https://packages.microsoft.com/config/ubuntu/$UBUNTU_VERSION/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

echog "nodejs"
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

echog "edge"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
sudo rm microsoft.gpg

echog "docker"
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echog "updating packages"
sudo apt update
sudo apt upgrade -y

echog "installing git"
sudo apt install git -y
git config --global user.name $GIT_USER_NAME
git config --global user.email $GIT_USER_EMAIL

echog "installing spotify"
sudo snap install spotify

echog "installing steam"
sudo apt install steam-installer -y

echog "installing vlc"
sudo apt install vlc -y

echog "installing python"
sudo apt install python3 python3-pip python-is-python3 curl -y

echog "installing gnome-tweaks"
sudo apt install gnome-tweaks gnome-shell-extension-caffeine -y

echob "################################################################################"
echob "#"
echob "# Dotnet"
echob "#"
# https://docs.microsoft.com/en-us/dotnet/core/install/
echog "installing dotnet"
sudo apt install apt-transport-https -y
sudo apt update
sudo apt install dotnet-sdk-5.0 -y

echob "################################################################################"
echob "#"
echob "# NodeJs"
echob "#"
sudo apt install nodejs -y
sudo npm install -g yarn

echob "################################################################################"
echob "#"
echob "# Flutter"
echob "#"
sudo apt install android-platform-tools-base -y
sudo snap install flutter --classic

echob "################################################################################"
echob "#"
echob "# Visual Studio Code"
echob "#"
echog "installing vscode"
sudo apt install code

echog "some vscode extensions"
code --install-extension ms-dotnettools.csharp
code --install-extension kisstkondoros.vscode-codemetrics
code --install-extension visualstudioexptteam.vscodeintellicode
code --install-extension ritwickdey.liveserver
code --install-extension naumovs.color-highlight
code --install-extension pkief.material-icon-theme
code --install-extension dart-code.dart-code
code --install-extension dart-code.flutter

echob "################################################################################"
echob "#"
echob "# Edge"
echob "#"
# https://www.microsoftedgeinsider.com/pt-br/download?platform=linux-deb
echog "installing edge"
sudo apt install microsoft-edge-dev -y

echob "################################################################################"
echob "#"
echob "# Docker"
echob "#"
echog "installing docker"
sudo apt install docker-ce docker-ce-cli containerd.io -y
# https://docs.docker.com/engine/install/linux-postinstall/
echog "docker without sudo"
sudo groupadd docker
sudo usermod -aG docker $USER

echob "################################################################################"
echob "#"
echob "# Art"
echob "#"
sudo apt install blender gimp inkscape audacity ffmpeg youtube-dl -y

echob "################################################################################"
echob "#"
echob "# Custom Terminal"
echob "#"
echog "pokemon terminal"
pip3 install git+https://github.com/LazoCoder/Pokemon-Terminal.git

echog "installing tilix and zsh"
sudo apt install tilix tmux fonts-firacode zsh -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echog "default terminal"
sudo update-alternatives --config x-terminal-emulator

echig "set agnoster zshtheme"
sed -i "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"agnoster\"/" ~/.zshrc

echog "set zsh by default"
chsh -s $(which zsh)

echog "Done! 😎"
