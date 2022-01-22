#!/data/data/com.termux/files/usr/bin/bash

path="/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu"

#install proot
pkg install proot proot-distro -y

#install ubuntu
proot-distro install ubuntu
printf "\033[;32mINFO\033[0m [going to proot environment]\n"
proot-distro login ubuntu --termux-home << EOF
bash packages.sh
EOF
