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
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
   xserver-xorg-video-fbdev  \
   xserver-xorg-core \
   xserver-xorg \
   xserver-xorg-legacy \
   x11-xserver-utils \
   xinit \
   unclutter \ 
   chromium-browser \
   mosquitto-clients

#
# Add files
#

# Set display and open Chromium-browser
ADD .xinitrc /home/pi/
RUN chown pi:pi -R /home/pi/
# create config folder
RUN mkdir -p /etc/X11/xorg.conf.d 

#
# set mqtt 
#
ADD display-power.sh /home/pi/ 
RUN chmod +x /home/pi/display-power.sh
ADD mqtt.sh /home/pi/ 
RUN chmod +x /home/pi/mqtt.sh


#
# set X settings
#

RUN echo "#!/bin/bash" > /etc/X11/xinit/xserverrc \
  && echo "" >> /etc/X11/xinit/xserverrc \
  && echo 'exec /usr/bin/X -s 0 dpms  -nolisten tcp "$@"' >> /etc/X11/xinit/xserverrc

RUN echo "#!/bin/bash" > /home/pi/start.sh \
  && echo "" >> /home/pi/start.sh \
  && echo 'rm /tmp/.X0-lock &>/dev/null || true' >> /home/pi/start.sh \
  && echo ' "( /home/pi/mqtt.sh ) &"' >> /home/pi/start.sh \
  && echo 'startx "/home/pi/.xinitrc"' >> /home/pi/start.sh

RUN echo 'allowed_users=anybody' > /etc/X11/Xwrapper.config
RUN chown pi:pi /home/pi/start.sh && chmod +x /home/pi/start.sh

#
# Add mouse support
#

ADD 45-evdev.conf /etc/X11/xorg.conf.d/
ADD 99-calibration.conf /etc/X11/xorg.conf.d/

#
# Set user to pi
#
RUN usermod -a -G input pi 
USER pi
WORKDIR /home/pi

CMD ["bash", "start.sh"]
