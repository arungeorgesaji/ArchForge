#!/bin/bash

#Change the value of the variables according to your requirements
#If any variable has reference inside the reference folder please follow the exact casing and exact spelling

#Full path to the drive should be included like /dev/nvme0n1
#lsblk command might help you find the right drive
drive_name="/dev/nvme0n1"    

#Partition suffix means like for some drives I have seen like nvme0n1 partitions are nvme0#n1p1,nvme0n1p2,nvme0n1p3 and nvme0n1p4 here my partition suffix is p yours might not have#something like this and might go with just the number in that case leave this blank 
partition_suffix="p"

#Storage reserved for swap directly in GiB
#Swap is like used when your device is low on ram and exchanges stuff to the drive
#Its recommended to have swap even if you have a lot of ram
#The value should be just a number such as 16
swap_storage_space="16"

#Storage reserved for root directly in GiB
#Root is where all the packages and all the basic stuff to run the os is installed to
#I like to have a bigger root as i see myself using it a lot atleast 25GiB is recommended
#The value should just be a number such as 64
root_storage_space="128"

#Network information wont be used if internet is accessible so if ethernet is connected or #you have already configured Internet,then these information will be ignored

#The SSID/name of your internet
network_SSID="" 

#The interface being used to communicate with internet such as wlan0
network_interface=""

#The password of your internet
network_password=""

#Hostname
hostname="ArchLinux"

#Host password
host_password=""

#Users and their password
#You can add as many users as you want,seperate each one with a space,all of them should b#inside the same bracket,username of a user should be written in square brackets and that #user's password should be seperated using an equal sign something like ["user"]="password#"
declare -A users=([""]="")

#Language
#Use space to specify to seperate each language if you want to use multiple languages and a#lso wrap each language with "" and all of them should be inside the same brackets'
#Check references/languages.txt for getting all the available options
languages=("en_US.UTF-8 UTF-8")

#Default language number
#The number you gave ranges from 1 which will mean the 1st language you gave in the array above which is languages,if you don't give a correct number the language wont be set as def#ault or exported correctly
default_language_number=1

#The zoneinfo of the user used for setting the correct time
#Check references/zoneinfo.txt for getting all the available options
zoneinfo="Asia/Kolkata"

#Which network management tool would you like to have on your system
#(We wont allow you to install more than one here as that will just cause conflict between the tools)
#Check references/network_management_tools.txt for getting all the available options
network_management_tool="NetworkManager"

#Which bluetooth management tool would you like to have on your system
#(We wont allow you to install more than one here as that will just cause conflict between the tools)
#Check references/bluetooth_management_tools.txt for getting all the available options
bluetooth_management_tool="Blueman"

#A yes or no variable which defines if the user uses an nvidia gpu
uses_nvidia_gpu="yes"

#A yes or no variable which defines if the user uses an ssd or not(use lowercase yes/no)
uses_ssd="yes"

#A yes or no variable which checks if the user wants 32bit support(use lowercase yes/no)
#Its recommended to have 32bit support unless you really know that you don't want it
#Note:This is for 32bit support for 64bit systems
enable_32bit_support="yes"

#A yes or no variable which checks if the user wants to use their root password instead of#their user password everytime password is needed for like installing stuff or changing 
#something
#It is recommended to turn this on to increase security
rootpw="yes"


