#!/bin/bash
ver="0.2"
#Check if root
if [ "$EUID" -ne 0 ]
        then echo "ERROR! You must run as ROOT!"
        exit
fi
#Introduction
clear
echo "[INTRODUCTION]"
echo "OS/RX UPGRADE SCRIPT VERSION $ver"
echo "This script will upgrade your system to OS/RX \"Sauter\" 27."
echo "Please back up your important files as system upgrades may not always work."
echo "Before running, make sure your system has a stable connection to the internet."
echo "Press [ENTER] to start."
read enter
#Move all Debian 11 compatible sources to the "OLD" folder
clear
echo "[STEP 1 OF 3 - REPOSITORIES]"
echo "This step will change your APT sources lists so that the system upgrade may begin."
echo "Your old .sources files will be in \"/etc/apt/sources.list.d/OLD/\"."
echo "Press [ENTER] to start."
read enter
cd /etc/apt/sources.list.d/
sudo mkdir OLD
sudo cp *.sources OLD/*.oldsources
#Replace old Debian 11 sources with new Debian 12 sources
echo "deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware" >> "debian.list"
echo "deb http://security.debian.org/ bookworm-security non-free contrib main non-free-firmware" >> "debian.list"
echo "deb http://deb.debian.org/debian/ bookworm-updates non-free contrib main non-free-firmware" >> "debian.list"
echo "deb http://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware" >> "debian.list"
sudo apt update -y
#Minimal system upgrade
clear
echo "[STEP 2 OF 3 - SYSTEM UPGRADE]"
echo "This step will download and upgrade your system to OS/RX 27 (Debian 12 based)."
echo "As said in the introduction please make sure you back up any important files."
echo "This may take from 5 minutes to some hours depending on your network and CPU".
echo "Press [ENTER] to start."
read enter
sudo apt upgrade --without-new-pkgs -y
sudo apt full-upgrade -y
sudo update-grub
echo "------------------------------------"
echo "[STEP 3 OF 3 - SYSTEM REBOOT]"
echo "To complete your system upgrade you must reboot your computer manually."
echo "Press enter to close this script"
read enter