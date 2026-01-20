#This basically installs all the packages I use and configures them and stuff
#Unless you want to try my configuration,you are free to delete all the content in this fi#le and change according to your requirements

#Change directory into the newly created user directory(this is the one I made)
cd home/arun 

#Run system update to get all the latest packages
sudo pacman -Syu

#Install all the packages I require from pacman using pacman
sudo pacman -S wget openssh git nano vim neovim rofi kitty ly godot blender gimp inkscape krita obs-studio lf xorg-server xorg-xinit xorg-apps plasma-desktop pavucontrol shotcut uget qbittorrent feh dunst pamixer upower scrot xclip ardour tldr cups python lf kitty libvirt virt-manager qemu-base vlc unzip tar vivaldi firefox steam openscad solanum autorandr pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber bluez-plugins nvidia-prime linux-headers 


#Install yay so that it can assist in AUR packages installations 
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

#Install all the packages I require from the AUR using yay
yay -S linux-wifi-hotspot yaycache autojump picom-git python39 python310 trash-cli wireshark-git ms-365-electron-bin conda fastfetch-git postman-bin ani-cli debtap bambustudio-bin

#Install pip for pyhon versions installed from AUR
python3.9 -m ensurepip --upgrade
python3.9 -m pip install pip --upgrade

#Install all the packages/software I require from github(not available or working properly#through pacman or AUR)
git clone https://github.com/P3rf/rofi-network-manager.git

#Create all the directories I need
mkdir -p Desktop Downloads Documents Music Pictures Videos .config/lf .config/dunst .config/kitty .config/picom .config/rofi .config/slock .config/nvim .config/fastfetch 

git clone https://github.com/arungeorgesaji/dotfiles.git 
sudo mv dotfiles/.bashrc .
sudo mv dotfiles/.xinitrc .
sudo mv dotfiles/bash .
sudo mv dotfiles/dwm .config 
cd .config/dwm
sudo make install
cd ../..
sudo mv dotfiles/dwmblocks .config 
cd .config/dwmblocks
sudo make install
cd ../..
sudo mv dotfiles/slock .config 
cd .config/slock
sudo make install
cd ../..
sudo mv dotfiles/lf/lfrc .config/lf 
sudo mv dotfiles/dunst/dunstrc .config/dunst
sudo mv dotfiles/kitty/kitty.conf .config/kitty
sudo mv dotfiles/picom/picom.conf .config/picom
sudo mv dotfiles/wallpapers Pictures 
sudo mv dotfiles/rofi/rofi-themes/* ../../usr/share/rofi/themes
sudo mv dotfiles/rofi/config.rasi .config/rofi  
sudo mv dotfiles/fastfetch/config.jsonc .config/fastfetch
sudo mv dotfiles/nvim/ .config/nvim 

#Enable the services I want to run of startup
sudo systemctl enable ly@tty2.service
sudo systemctl enable libvirtd.service 
sudo systemctl enable bluetooth.service

#Edit the other settings i need
sudo usermod -a -G libvirt arun

#Delete dotfiles as its not needed anymore
sudo rm -R dotfiles

