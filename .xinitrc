#!/usr/bin/env sh
xset -dpms
xset s off
xset s noblank

unclutter &
chromium-browser $URL \
  --window-size=1024,600 \
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
