![Docker](https://github.com/Kipjr/docker-display/workflows/Docker/badge.svg)
# docker-display
Docker container to display Chromium-browser for kiosk-applications

Size:  881MB

## Issues:

- None

## Hardware
- Raspberry Pi 4 (4GB)
- WS170120 Touch Screen (https://www.waveshare.com/wiki/7inch_HDMI_LCD_(H)_(with_case))

## Configration

# /boot/config.txt

- max_usb_current=1
- hdmi_group=2
- hdmi_mode=87
- hdmi_cvt 1024 600 60 6 0 0 0

# docker-compose.yml

- MQTT_HOST=192.168.1.1
- MQTT_PORT=1433
- MQTT_TOPIC=scripts/display/power
- URL=http://Google.nl
- WIDTH=1366
- HEIGHT=800
- CHROMIUMFLAGS='--window-position=0,0 --start-fullscreen --kiosk --incognito'

## Sources


- https://sylvaindurand.org/launch-chromium-in-kiosk-mode/#:~:text=Chromium%20makes%20it%20easy%20to,display%20or%20on%20a%20terminal%E2%80%A6
- https://www.waveshare.com/wiki/7inch_HDMI_LCD_(H)_(with_case)
- https://www.waveshare.com/wiki/5inch_HDMI_LCD_(B)_(Firmware_Rev_2.1)_User_Manual
- https://stackoverflow.com/questions/33585482/keyboard-mouse-are-unresponsable-when-running-x-org-in-a-docker-containe
- https://wiki.ubuntu.com/X/InputCoordinateTransformation
- https://help.ubuntu.com/community/TabletSetup
- https://jonathanmh.com/raspberry-pi-4-kiosk-wall-display-dashboard/
- https://forums.balena.io/t/cant-get-chromium-browser-working/142217
- https://forums.balena.io/t/create-a-non-root-user-on-x11-window-manager/63131 
- https://github.com/balena-io-examples/x11-window-manager/blob/master/Dockerfile.raspberrypi3
- https://www.balena.io/blog/running-a-desktop-manager-with-balena/
- http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
- https://askubuntu.com/questions/1161646/is-it-possible-to-run-docker-container-and-show-its-graphical-application-window
- https://hub.docker.com/r/thomaskatalis/rpi-kiosk/dockerfile
- https://github.com/waveshare/LCD-show
- bpfcc-tools libcap-ng-utils  /usr/share/bcc/tools/capable & pscap
  
