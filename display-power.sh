#!/bin/bash


case $1 in

   off)
    sudo docker exec display  xset s off #turn screensaver permanent off
     ;;

   reset)
    sudo docker exec display xset s reset #turn screensaver off
     ;;

   on)
    sudo docker exec display xset s on #turn screensaver permanent on
     ;;

   activate)
    sudo docker exec display xset s activate #turn screensaver on
    ;;

  default)
    sudo docker exec display xset s 60 60  #turn screensaver on after 60 sec
    sudo docker exec display xset s on  #turn screensaver on
    ;;


  longon)
    sudo docker exec display xset s 900 900 #turn screensaver on after 15min
    sudo docker exec display xset s on #turn screensaver on
     ;;


