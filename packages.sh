#!/bin/bash

echo "checking and installing updates..."
apt update
apt upgrade -y

echo "installing needed packages..."
apt install xfce4 tightvncserver nano wget sudo thunar -y

echo "please enter new username"

read user
if [ -z "$user" ];
then echo "please enter any user before proceeding";
else printf "your username: $user.\n this may ask to create password." adduser $user && adduser $user sudo; fi
echo "setting up vnc..."
echo "this is where you open the desktop GUI"
sleep 2
echo "vncserver -geometry 1024x768 -depth 24 -name remote-desktop :1" > /usr/local/bin/vncserver-start
echo "vncserver -kill :1 && rm -rf /tmp/.X1-lock && rm -rf /tmp/.X11-unix/X1" > /usr/local/bin/vncserver-stop
chmod a+x /usr/local/bin/vncserver*

echo "you need to setup admin rights manually"
sleep 2
visudo

su $user << EOF
echo "create a vnc password"
vncpasswd
printf "you could start vncserver again later by running vncserver-start \n\n"
printf "you could stop it by running vncserver-stop \n\n"
echo "starting vncserver now"
vncserver-start
echo "Done. you could now connect with a vnc viewer"
printf "setting up login script. \n you could login to ubuntu later by running ./proot-login.sh"
echo "proot-distro login ubuntu --user $user --bind /sdcard:/sdcard" > ~/proot-login.sh
EOF
