#!/bin/bash

# Pacotes apt
apt_packages =(vim git curl zip unzip snapd snapd-xdg-open ubuntu-restricted-extras gparted)

for p in "${apt_packages[@]}"
do
 sudo apt install $p -y
done

# Chrome

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
DIRETORIO_DOWNLOADS="$HOME/Downloads/"
wget -c "$URL_GOOGLE_CHROME" -P "$DIRETORIO_DOWNLOADS"
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# SDKMan e Java 8 
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 8.0.232.j9-adpt 

# Node 12
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install -y nodejs

# Snap 
sudo snap install --classic vscode
sudo snap install --classic slack
sudo snap install spotify
sudo snap install discord
sudo snap install vlc
sudo snap install zoom
sudo snap install postman


sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y

# Docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce
sudo usermod -aG docker ${USER}
su - ${USER}