ARG OS_VERSION=ubuntu:18.04
FROM ${OS_VERSION}
#
# User Actions
#

RUN useradd -ms /bin/bash display && \
    usermod -a -G video display && \
    usermod -a -G tty display

#
# Install core 
#

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
mkdir -p /etc/X11/xorg.conf.d && \
mkdir -p /var/log/supervisor && \
echo $TZ > /etc/timezone && 
[[ "$OS_VERSION" == "debian:bookworm" ]] && BROWSER=chromium || BROWSER=chromium-browser &&
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
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf 
ADD .xinitrc /home/display/
ADD .xserverrc /home/display/
ADD display-power.sh /home/display/ 
ADD mqtt.sh /home/display/ 
ADD start.sh /home/display/
ADD 45-evdev.conf /etc/X11/xorg.conf.d/
ADD 99-calibration.conf /etc/X11/xorg.conf.d/
ADD Xwrapper.config /etc/X11/

RUN chmod +x /home/display/*.sh && \
	chmod 0750 /home/display/.x* && \
	usermod -a -G input display && \
	mkdir -p /home/display/.config/chromium && \
	chown display:display -R /home/display/
WORKDIR /home/display
VOLUME /home/display/.config/chromium

USER display

#CMD ["bash", "start.sh"]
#CMD ["tail", "-f","/dev/null"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
