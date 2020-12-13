#!/bin/sh
#xset -display 127.0.0.1:0 +dpms 0 0 300
#xset -display 127.0.0.1:0 s 0 0
#xset -display 127.0.0.1:0 s noblank
#xset -display 127.0.0.1:0 s noexpose

#unclutter &
chromium-browser https://home.koetsier.dev   --no-sandbox --window-size=1024,600 \
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
  --disable-gpu-sandbox \
  --disable-features=TranslateUI \
  --disk-cache-dir=/dev/null \
  --overscroll-history-navigation=0 \
  --disable-pinch

