FROM ubuntu:18.04

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#
# User Actions
#

RUN useradd -ms /bin/bash pi
RUN usermod -a -G video pi
RUN usermod -a -G tty pi

#
# Install core 
#

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
   xserver-xorg-video-fbdev  \
   xserver-xorg-core \
   xserver-xorg \
   xserver-xorg-legacy \
   x11-xserver-utils \
   xinit \
   unclutter \ 
   chromium-browser \
   mosquitto-clients

RUN apt-get autoremove -y

#
# Add files
#

RUN mkdir -p /etc/X11/xorg.conf.d 

ADD .xinitrc /home/pi/
ADD .xserverrc /home/pi/
ADD display-power.sh /home/pi/ 
ADD mqtt.sh /home/pi/ 
ADD start.sh /home/pi/
ADD 45-evdev.conf /etc/X11/xorg.conf.d/
ADD 99-calibration.conf /etc/X11/xorg.conf.d/
ADD Xwrapper.config /etc/X11/

RUN chown pi:pi -R /home/pi/
RUN chmod +x /home/pi/*.sh
RUN chmod 0750 /home/pi/.x*

#set user
RUN usermod -a -G input pi 
USER pi
WORKDIR /home/pi

CMD ["bash", "start.sh"]
#CMD ["tail", "-f","/dev/null"]
