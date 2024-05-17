#!/bin/bash

source setup_variables.sh

#These contain all the variables needed for the installation

#Parititions
boot="${drive_name}${partition_suffix}1"
swap="${drive_name}${partition_suffix}2"
root="${drive_name}${partition_suffix}3"
home="${drive_name}${partition_suffix}4"

#Mount points
mnt="/mnt"
mnt_boot="/mnt/boot"
mnt_home="/mnt/home"

#Default language index
default_language_index=$((default_language_number - 1))

#Mirrorlist path
mirrorlist="/etc/pacman.d/mirrorlist"
mirrorlist_backup="/etc/pacman.d/mirrorlist.backup"
