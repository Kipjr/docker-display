#!/usr/bin/env sh
xset +dpms
xset s on
xset s 60 60
#xset s noblank
xrandr --output HDMI-1 --rotate inverted
unclutter &
chromium-browser $URL \
  --window-size=$WIDTH,$HEIGHT \
  --window-position=0,0 \
  --start-fullscreen \
  --kiosk \
  --incognito \
  --noerrdialogs \
  --disable-translate \
  --no-first-run \
  --fast \
  --fast-start \
  --disable-infobars \
  --disable-features=TranslateUI \
  --disk-cache-dir=/tmp/chromium \
  --overscroll-history-navigation=0 \
  --disable-pinch 
 # --user-data-dir=/home/pi/.config/chromium/weblink https://chrome.google.com/webstore/detail/virtual-keyboard/pflmllfnnabikmfkkaddkoolinlfninn
