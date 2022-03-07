#!/data/data/com.termux/files/usr/bin/bash
#going to home dir

{

date="$(date +%D)"
echo "log date is $date"


cd ~

pkg update -y && pkg upgrade -y && apt install wget git -y

if [ -f "./packages.sh" ]; then
 printf "\033[;32mINFO [needed files already downloaded. proceeding...]\033[0m \n"
else
 printf "\033[;32mINFO  [downloading files] \033[0m\n"
wget https://raw.githubusercontent.com/magbulogtong81/automate-proot-ubuntu/main/packages.sh
fi

#install proot
apt install proot proot-distro binutils -y

#install ubuntu
proot-distro install ubuntu
printf "\033[;32mINFO\033[0m [going to proot environment]\n"


#output all to stderr and save it
#this way we still able to see it
#this also prevents breaking nano


proot-distro login ubuntu --bind $HOME:/root/termux -- bash /root/termux/packages.sh
}>  >(tee -a ubuntu-install.log >&2)
rm -rf install-ubuntu-desktop.sh packages.sh

./proot-start.sh
