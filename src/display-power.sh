#!/bin/bash
DISPLAY=$(ps -aux | grep -Pe 'Xorg'| grep -Po '(?<= )(:[0-9]+) ')
declare -x DISPLAY=$DISPLAY

case $1 in

   off)
     xset -display $DISPLAY s off #turn screensaver permanent off
     ;;

   reset)
    xset -display $DISPLAY s reset #turn screensaver off
     ;;

   on)
    xset -display $DISPLAY s on #turn screensaver permanent on
     ;;

   activate)
    xset -display $DISPLAY s activate #turn screensaver on
    ;;

  default)
    xset -display $DISPLAY s 60 60  #turn screensaver on after 60 sec
    xset -display $DISPLAY s on  #turn screensaver on
    ;;


  longon)
    xset -display $DISPLAY s 900 900 #turn screensaver on after 15min
    xset -display $DISPLAY s on #turn screensaver on
     ;;


esac
