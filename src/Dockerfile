ARG BROWSER=chromium-browser
ARG VERSION_UBUNTU=18.04
FROM ubuntu:${VERSION_UBUNTU}
#
# User Actions
#

RUN useradd -ms /bin/bash display
RUN usermod -a -G video display
RUN usermod -a -G tty display

#
# Install core 
#

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
mkdir -p /etc/X11/xorg.conf.d && \
mkdir -p /var/log/supervisor && \
echo $TZ > /etc/timezone && \
apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
   xserver-xorg-video-fbdev  \
   xserver-xorg-core \
   xserver-xorg \
   xserver-xorg-legacy \
   x11-xserver-utils \
   libgtk-3-bin \
   xinit \
   unclutter \
   ${BROWSER} \
   mosquitto-clients \
   supervisor

#
# Add files
#
RUN --mount=type=bind,source=./,target=/mnt \
  cd /mnt && \
  cp .xserverrc /home/display/ && \
  cp .xinitrc /home/display/ && \
  cp display-power.sh /home/display/ && \
  cp mqtt.sh /home/display/ && \
  cp 99-calibration.conf /etc/X11/xorg.conf.d/ && \
  cp 45-evdev.conf /etc/X11/xorg.conf.d/ && \
  cp Xwrapper.config /etc/X11/ && \
  cp start.sh /home/display/ && \
  cp supervisord.conf /etc/supervisor/conf.d/supervisord.conf && \
  if [ "$BROWSER" == 'chromium-browser' ]; then \
    mkdir -p /home/display/.config/chromium && \
    cp preferences.json /home/display/.config/chromium/Default/Pref && \
    cp chromium-browser.supervisord.conf /etc/supervisor/conf.d/chromium.conf \
  elif [ "$BROWSER" == 'firefox' ]; then
    echo 1
  fi

RUN chmod +x /home/display/*.sh && \
	chmod 0750 /home/display/.x* && \
	usermod -a -G input display && \
	chown display:display -R /home/display/
WORKDIR /home/display
VOLUME /home/display/.config/chromium

USER display

#CMD ["bash", "start.sh"]
#CMD ["tail", "-f","/dev/null"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
