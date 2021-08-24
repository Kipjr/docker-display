#!/bin/bash


case $1 in

   off)
     xset s off #turn screensaver permanent off
     ;;

   reset)
    xset s reset #turn screensaver off
     ;;

   on)
    xset s on #turn screensaver permanent on
     ;;

   activate)
    xset s activate #turn screensaver on
    ;;

  default)
    xset s 60 60  #turn screensaver on after 60 sec
    xset s on  #turn screensaver on
    ;;


  longon)
    xset s 900 900 #turn screensaver on after 15min
    xset s on #turn screensaver on
     ;;


