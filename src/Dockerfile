FROM ubuntu:18.04

#
# User Actions
#

RUN useradd -ms /bin/bash pi
RUN usermod -a -G video pi
RUN usermod -a -G tty pi

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
   chromium-browser \
   mosquitto-clients \
   supervisor

#
# Add files
#
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf 
ADD .xinitrc /home/pi/
ADD .xserverrc /home/pi/
ADD display-power.sh /home/pi/ 
ADD mqtt.sh /home/pi/ 
ADD start.sh /home/pi/
ADD 45-evdev.conf /etc/X11/xorg.conf.d/
ADD 99-calibration.conf /etc/X11/xorg.conf.d/
ADD Xwrapper.config /etc/X11/

RUN chmod +x /home/pi/*.sh && \
	chmod 0750 /home/pi/.x* && \
	usermod -a -G input pi && \
	mkdir -p /home/pi/.config/chromium && \
	chown pi:pi -R /home/pi/
WORKDIR /home/pi
VOLUME /home/pi/.config/chromium

USER pi

#CMD ["bash", "start.sh"]
#CMD ["tail", "-f","/dev/null"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
