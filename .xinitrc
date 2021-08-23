#!/usr/bin/env sh
xset +dpms
xset s on
xset s 60 60
xrandr --output HDMI-1 --rotate inverted
unclutter &
chromium-browser $URL \
  --window-size=$WIDTH,$HEIGHT \
  --window-position=0,0 \
${CHROMIUMFLAGS}
