#!/bin/bash

# Bash script with all the variables needed for this file to run,some of the variables are derived from setup_variables.sh which are to be changed according to your requirements
source variables.sh

# Uncomment necessary locales/languages
for loc in "${languages[@]}"; do
    # Use sed to uncomment lines containing the specified locale
    sed -i "/^#.*$loc/s/^#//" /etc/locale.gen
done

# Generate locales
locale-gen

# Set the default language
echo "LANG=${languages[$default_language_index]}" > /etc/locale.conf

# Export the default language
export LANG="${languages[$default_language_index]}"

# Set the time of the system and also the hardware clock
timedatectl set-timezone "$zoneinfo"
sudo hwclock --systohc

# Set the hostname
echo "$hostname" > /etc/hostname

# Enable automatic TRIM operation scheduling for SSD optimization if user uses an SSD
if [ "$uses_ssd" = "yes" ]; then
    sudo systemctl enable fstrim.timer
fi

# Enable multilib to get 32 bit support on 64bit systems if the user wants it
if [ "$enable_32bit_support" = "yes" ]; then 
    sudo sed -i '/^\[multilib\]$/,/^\s*$/ s/^#*\s*Include\s*=.*/Include = \/etc\/pacman.d\/mirrorlist/; /^\s*Include\s*=/ s/^#*//' /etc/pacman.conf
fi

# Set the password for root
echo "root:$host_password" | sudo chpasswd

# Make users and set their password
for user in "${!users[@]}"; do
    useradd -m -g users -G wheel,storage,power -s /bin/bash ${user}
    echo "$user:${users[${user}]}" | sudo chpasswd
done

# Allows the users of group wheel to execute any command
sudo sed -i '/^# %wheel/s/^# //' /etc/sudoers

if [ "$rootpw" = "yes" ]; then 
  echo "Defaults rootpw" >> /etc/sudoers
fi

bootctl install

# Write a boot entry
sudo touch /boot/loader/entries/arch.conf
sudo tee /boot/loader/entries/arch.conf <<EOF
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
EOF
echo "options root=PARTUUID=$(blkid -s PARTUUID -o value "$root") rw" >> /boot/loader/entries/arch.conf

# Install the network management tool the user wants

#Install and enable NetworkManager if the user wants it as their network management tool
if [ "$network_management_tool" = "NetworkManager" ]; then 
  sudo pacman -S networkmanager
  sudo systemctl enable NetworkManager.service

#Install netctl if the user wants it as their network management tool
#It manages networks from individual profile pages from /etc/netctl so enabling is not re#quired
elif [ "$network_management_tool" = "netctl" ]; then
  sudo pacman -S netctl

#Install and enable Wicd if user wants it as their network management tool
elif [ "$network_management_tool" = "Wicd" ]; then
  sudo pacman -S wicd
  sudo systemctl enable wicd.service

#Install and enable Connman if the user wants it as their network management tool
elif [ "$network_management_tool" = "Connman" ]; then
  sudo pacman -S connman 
  sudo systemctl enable connman.service

#Install and enable dhcpcd if the user wants it as their network management tool
elif [ "$network_management_tool" = "dhcpcd" ]; then
    sudo pacman -S dhcpcd
    sudo systemct enable dhcpcd.service

fi

# Install the bluetooth management tool the user wants

#Install and enable Bluez if the user wants it as their bluetooth management tool
if [ "$bluetooth_management_tool" = "Bluez" ]; then 
  sudo pacman -S bluez-utils

#Install and enable Blueman if the user wants it as their bluetooth management tool
elif [ "$bluetooth_management_tool" = "Blueman" ]; then 
  sudo pacman -S blueman

#Install and enable Blueberry if the user wants it as their bluetooth management tool
elif [ "$bluetooth_management_tool" = "Blueberry" ]; then 
  sudo pacman -S blueberry

fi 

# Install headers and C files for building external kernel modules
sudo pacman -S linux-headers

# Install NVIDIA drivers if the user uses an NVIDIA GPU
if [ "$uses_nvidia_gpu" = "yes" ]; then 

    # install the drivers
    sudo pacman -s nvidia-dkms libglvnd nvidia-utils opencl-nvidia lib32-libglvnd lib32-nvidia-utils lib32-opencl-nvidia nvidia-settings

    # add the drivers to initramfs so it loads on boot even before kernel starts
    sed -i "/^modules=/ s/)/ nvidia nvidia_modeset nvidia_uvm nvidia_drm)/" /etc/mkinitcpio.conf

    # drm is something important for the gpu to work properly this line enables it
    sed -i '/^options/ s/$/ nvidia-drm.modeset=1/' /etc/loader/entries/arch.conf

    # writes nvidia.hook which updates mkinitpcio when a new nvidia driver is installed, driver is removed or it is updated
    # basically it allows you the system to update the information regarding the nvidia drivers when it's installed, updated, or removed.
    sudo mkdir -p /etc/pacman.d/hooks
	sudo touch /etc/pacman.d/hooks/nvidia.hook
    sudo tee /etc/pacman.d/hooks/nvidia.hook <<eof
    [trigger]
    operation=install
    operation=upgrade
    operation=remove
    type=package
    target=nvidia

    [action]
    depends=mkinitcpio
    when=posttransaction
    exec=/usr/bin/mkinitcpio -p
eof
fi

