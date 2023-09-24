#!/bin/bash
DISPLAY=$(ps -aux | grep -Pe 'Xorg'| grep -Po '(?<= )(:[0-9]+)(?=\ )')
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

  status)
    xset q #get status
     ;;

  dpmson)
    +dpms # EnergyStar Features on
    ;;

  dpmsoff)
    -dpms # EnergyStar Features off
    ;;

esac

# Screen Saver:
#  prefer blanking:  yes    allow exposures:  yes
#  timeout:  0    cycle:  60

# DPMS (Energy Star):
#  Standby: 0    Suspend: 0    Off: 0
#  DPMS is Enabled
#  Monitor is On
