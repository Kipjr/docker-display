#!/usr/bin/bash

rm /tmp/.X0-lock &>/dev/null || true

echo "Starting X in 2 seconds"
sleep 2
startx /home/pi/.xinitrc

while :
do
	echo "startx failed, so we will just wait here while you debug!"
	echo ""
	echo "/var/log/Xorg.*.log"
	cat /var/log/Xorg.*.log
	echo ""
	echo "/home/pi/.local/share/xorg/Xorg.*.log"
	cat /home/pi/.local/share/xorg/Xorg.*.log

	sleep 60
done
