#!/bin/bash
sudo add-apt-repository -y ppa:mozillateam/ppa
sudo apt install mosquitto-clients x11-xserver-utils  xserver-xorg-video-fbdev xinit unclutter xserver-xorg-input-evdev firefox-esr menu
mkdir -p /home/${USER}/.mozilla/firefox/profile.default/extensions;

#/etc/supervisord/firefox.conf
#/usr/lib/firefox/mozilla.cfg
#/usr/lib/firefox/defaults/pref/autoconfig.js
#/usr/lib/firefox/distribution/policies.json
#/home/adminuser/.mozilla/firefox/profiles.ini
#/etc/openbox/openbox.xml
