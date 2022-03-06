#!/bin/bash


##variable declerations
workdir=/root/termux


##functions

function cancelinfo(){
 echo "skipping browser installation"
 echo "you could install it later on by running"
 echo "\"sudo apt install chromium-browser -y\" for chromium; or"
 echo "\"sudo apt install firefox -y\" for firefox"
 printf "\n\n\n		press enter to continue"
 read a


}

function browser(){
while true
do
echo "would you like to install a browser? (y/n)"
read browser
if [[ $browser = "y" || $browser = "Y" ]];then
 echo "select which browser"
 printf "(input 1,2 or 3 to select) \n\n"
 echo "[1] chromium"
 echo "[2] firefox"
 echo "[3] cancel installation"
 read type
 case $type in
	1)
		sudo apt install chromium-browser -y
		break
		;;
	2)
		sudo apt install firefox -y
		break
		;;

	3)

		cancelinfo
		break
		;;

	*)
		echo "invalid option, try again"
		;;
 esac

elif [[ $browser = "n" || $browser = "N" ]]; then
 cancelinfo
 break

else
 printf "invalid option, try again \n\n\n"

fi

done

}


function setupuser(){
echo "we need to setup a \"user\""

while true
do

echo "please input username"
printf "username: "
read user

printf "you entered: $user\n\n"
printf "is this correct? (y/n)"
read choice

case $choice in
	y)
		echo "adding user to system with previlege"
		adduser $user
		adduser $user sudo
		export user=$user
		break
		;;
	*)
		printf "please try again \n\n\n"
		;;
esac


done


}

function setupsudo(){
while true
do

echo "clearing terminal"
clear
echo "we need to manually setup user previlege config"
echo "a text editor will pop-up to do so"
echo "underneath the line \"root    ALL=(ALL:ALL) ALL\","
echo 'we gonna need to add: your_username    ALL=(ALL:ALL) ALL'
echo "you could copy and paste it"
printf "\n\nPress enter to continue"
read a

visudo
if [[ "$(cat /etc/sudoers)" =~ $user ]]; then
 echo "successfully added."
 break

else
 echo "your username was not added, try again"
 echo "press enter to continue"
 read a

fi
done
}

function startscript(){
file=$workdir/proot-start.sh
echo "setting up start script"
echo "proot-distro login ubuntu --user $user \\" > $file
echo "\""'$@'"\"" >> $file
for i in `seq 3`
do sleep 1;
printf "."
done

chmod a+rwx $workdir/proot-start.sh

echo "done, to start ubuntu, execute:"
echo "\"./proot-start.sh\""


}


##main execution
echo "checking and installing updates..."
#apt update
#apt upgrade -y

echo "installing needed packages..."
#apt install xfce4 tightvncserver nano wget sudo thunar -y
browser
setupuser
setupsudo
startscript
echo "setting up vnc..."
echo "vncserver -geometry 1024x768 -depth 24 -name remote-desktop :1" > /usr/local/bin/vncserver-start
echo "vncserver -kill :1 && rm -rf /tmp/.X1-lock && rm -rf /tmp/.X11-unix/X1" > /usr/local/bin/vncserver-stop
chmod a+x /usr/local/bin/vncserver*

echo "this is where you open the desktop GUI"
echo "it may ask to create a vnc password"
echo "to start vnc, execute vncserver-start"
echo "to stop, execute vncserver-stop"

