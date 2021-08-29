#!/bin/bash
[[ -f /tmp/.X0-lock ]] && rm /tmp/.X0-lock
/home/pi/mqtt.sh &
startx
