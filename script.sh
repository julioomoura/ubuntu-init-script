#!/bin/bash

# Pacotes apt
apt_packages =(vim git curl zip unzip snapd snapd-xdg-open )

for p in "${apt_packages[@]}"
do
 sudo apt install $p -y
done

# SDKMan e Java 8 
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 8.0.232.j9-adpt 

# Node 12
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install -y nodejs

# Snap 
snap_packges = (vscode vlc postman slack spotify discord)
sudo snap install --classic vscode


