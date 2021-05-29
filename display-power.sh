#!/bin/bash

case $1 in

  off)
    sudo docker exec -it display  xset s off #turn screensaver permanent off
    ;;

  reset)
    sudo docker exec -it display xset s reset #turn screensaver off
    ;;

  on)
    sudo docker exec -it display xset s on #turn screensaver permanent on
    ;;
  activate)
    sudo docker exec -it display xset s activate #turn screensaver on
    ;;
esac


