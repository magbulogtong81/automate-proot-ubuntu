#!/bin/bash

echo "checking and installing updates..."
apt update
apt upgrade -y

echo "installing needed packages..."
apt install xfce4 tightvncserver nano wget sudo thunar -y

echo "setting up vnc..."
echo "this is where you open the desktop GUI"
sleep 2
echo "vncserver -geometry 1024x768 -depth 24 -name remote-desktop :1" > /usr/local/bin/vncserver-start
echo "vncserver -kill :1 && rm -rf /tmp/.X1-lock && rm -rf /tmp/.X11-unix/X1" > /usr/local/bin/vncserver-stop
chmod a+x /usr/local/bin/vncserver*
