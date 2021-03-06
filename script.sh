#!/bin/bash

# Pacotes apt
apt_packages=(vim git curl zip unzip nodejs snapd snapd-xdg-open ubuntu-restricted-extras gparted gnome-tweak-tool apt-transport-https ca-certificates software-properties-common tmux flameshot docker-ce)

sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y

# Docker Repository 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# Node 12
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

for p in "${apt_packages[@]}"
do
 sudo apt install $p -y
done

sudo usermod -aG docker ${USER}
sudo setfacl -m user:$USER:rw /var/run/docker.sock

# Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Chrome
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
DIRETORIO_DOWNLOADS="$HOME/Downloads/"
wget -c "$URL_GOOGLE_CHROME" -P "$DIRETORIO_DOWNLOADS"
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# SDKMan e Java 8 
curl -s "https://get.sdkman.io" | bash
source $HOME/.sdkman/bin/sdkman-init.sh
sdk install java 8.0.275.hs-adpt
sdk install maven

# Snap
snap_packages=("--classic code" "--classic slack" "intellij-idea-community --classic" spotify discord vlc postman dbeaver-ce)

for p in "${snap_packages[@]}"
do
 sudo snap install $p
done

sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y
