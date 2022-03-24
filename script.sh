#!/bin/bash

# Consts
DOWNLOADS_DIRECTORY="$HOME/Downloads/"
GREEN='\e[1;92m'
COLORLESS='\e[0m'


# Pacotes apt
apt_packages=(
    vim git curl zip unzip gparted gnome-tweak-tool flameshot flatpak apt-transport-https
    ca-certificates gnupg lsb-release wget
)

sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y

echo -e "${GREEN}[INFO] - Installing apt packages${COLORLESS}"

for p in "${apt_packages[@]}"
do
 sudo apt install $p -y
done

sudo usermod -aG docker ${USER}
sudo setfacl -m user:$USER:rw /var/run/docker.sock

# .debs
declare -A urls

urls=(
    ["chrome"]="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" 
    ["vscode"]="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    ["slack"]="https://downloads.slack-edge.com/releases/linux/4.24.0/prod/x64/slack-desktop-4.24.0-amd64.deb"
    ["discord"]="https://discord.com/api/download?platform=linux&format=deb"
    ["zoom"]="https://zoom.us/client/latest/zoom_amd64.deb"
    ["insomnia"]="https://updates.insomnia.rest/downloads/ubuntu/latest?&app=com.insomnia.app"
)

echo -e "${GREEN}[INFO] - Installing .deb packages${COLORLESS}"

for u in "${!urls[@]}"
do
  wget -c ${urls[$u]} -P "$DOWNLOADS_DIRECTORY" -O "${u}.deb"
done
sudo dpkg -i $DOWNLOADS_DIRECTORY/*.deb

# NVM
echo -e "${GREEN}[INFO] - Installing nvm${COLORLESS}"

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install --lts  

# SDKMan
echo -e "${GREEN}[INFO] - Installing sdkman${COLORLESS}"

curl -s "https://get.sdkman.io" | bash
source $HOME/.sdkman/bin/sdkman-init.sh
sdk install java
sdk install maven

# Flatpak
flatpak_packages=("com.spotify.Client" "org.videolan.VLC" " com.getpostman.Postman" "com.obsproject.Studio")

echo -e "${GREEN}[INFO] - Installing flatpak packages${COLORLESS}"

for p in "${flatpak_packages[@]}"
do
    flatpak install flathub $p -y
done

sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y

# Set flameshot as print-screen shortcut
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot '[]'
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'flameshot'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command '/usr/bin/flameshot gui'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding 'Print'

# Change git init default branch name to main
git config --global init.defaultBranch main


echo -e "${GREEN}[INFO] - Installing brave${COLORLESS}"
# Brave browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

echo -e "${GREEN}[INFO] - Installing docker${COLORLESS}"
# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io

  echo -e "${VERDE}[INFO] - FINISH${SEM_COR}"