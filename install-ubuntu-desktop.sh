#!/data/data/com.termux/files/usr/bin/bash
#going to home dir
cd ~

pkg update && pkg upgrade -y && apt install wget git

wget https://raw.githubusercontent.com/magbulogtong81/automate-proot-ubuntu/main/packages.sh

#install proot
apt install proot proot-distro binutils -y

#install ubuntu
proot-distro install ubuntu
printf "\033[;32mINFO\033[0m [going to proot environment]\n"
proot-distro login ubuntu --termux-home << EOF
bash ~/packages.sh
EOF
