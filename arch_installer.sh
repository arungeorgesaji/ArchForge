#!/bin/bash

# Bash script with all the variables needed for this file to run, some of the variables are derived from setup_variables.sh which are to be changed according to your requirements
source variables.sh

# Connect to an internet connection if it's not connected already
if ! ip addr show | grep -q 'state UP'; then
    iwctl --passphrase "$network_password" station "$network_interface" connect "$network_SSID"
fi

# Wipe out all the partitions and data inside the drive
sgdisk --zap-all "$drive_name"

# Create boot, swap, root, and home partitions
sgdisk --new=1:2048:+1G --typecode=1:ef00 --change-name=1:"boot" \
       --new=2:0:+"$swap_storage_space"G --typecode=2:8200 --change-name=2:"swap" \
       --new=3:0:+"$root_storage_space"G --typecode=3:8300 --change-name=3:"root" \
       --new=4:0:0 --typecode=4:8302 --change-name=4:"home" "$drive_name"

# Convert partitions into their right types and also create swap and enable it
mkfs.fat -f32 "$boot"
mkswap "$swap"
swapon "$swap"
mkfs.ext4 "$root"
mkfs.ext4 "$home"

# Creates directories for mounting and also mounts the partitions.
mount "$root" "$mnt"
mkdir "$mnt_boot"
mkdir "$mnt_home"
mount "$boot" "$mnt_boot"
mount "$home" "$mnt_home"

# Install some additional packages for the system
pacman -Sy pacman-contrib

# Backup the mirrorlist in case something happens and you need the original mirrorlist
cp "$mirrorlist" "$mirrorlist_backup"

# Generate best mirrorlist
rankmirrors -n 6 "$mirrorlist_backup" > "$mirrorlist"

# Install very important required dependencies for the system to work such as the kernel
pacstrap -K "$mnt" base linux linux-firmware base-devel

# Generate fstab
genfstab -U -p /mnt >> /mnt/etc/fstab

# Copy the needed files to the installed system
cp arch_post_installer.sh setup_variables.sh variables.sh my_config_installer.sh "$mnt"

# Execute commands inside the installed system by making its root the apparent root temporarily inside the installer (it also manages many other tasks such as mounting special filesystems for the proper working of this temporary root)
arch-chroot "$mnt" /bin/bash -c "
# Give necessary permissions to the files which are to be executed
    chmod +x arch_post_installer.sh
    chmod +x my_config_installer.sh 

# Run the arch_post_installer.sh scripts which helps automates post arch installation
    ./arch_post_installer.sh 

# Run the my_config_installer.sh script(in the user level environment as a lot of these st#uff will make the system not function as expected if ran as root)which will help install #whatever config, specific packages or anything you need
#Please make adjustments to my_config_installer.sh to match your preferences, by default the script matches my preferences
    su arun /bin/bash -c "./my_config_installer.sh"

# Delete the copied files as they are not needed anymore 
    rm arch_post_installer.sh setup_variables.sh variables.sh my_config_installer.sh

"

# Unmount everything and finally reboot
# If the system doesn't work as expected after this, please remove the code under this and try to debug it yourself or reach out to someone who might be able to help you
umount -R "$mnt"
# reboot
