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
   xinit \
   unclutter \ 
   chromium-browser

#
# Add files
#

# Start the X-server script
ADD start.sh /home/pi/
# Set display and open Chromium-browser
ADD .xinitrc /home/pi/
# Pi may use X11
ADD Xwrapper.config /etc/X11/ 
# create config folder
RUN mkdir -p /etc/X11/xorg.conf.d 

#
# set X settings
#

RUN echo "#!/bin/bash" > /etc/X11/xinit/xserverrc \
  && echo "" >> /etc/X11/xinit/xserverrc \
  && echo 'exec /usr/bin/X -s 0 dpms  -nolisten tcp "$@"' >> /etc/X11/xinit/xserverrc
  #&& echo 'exec /usr/bin/X -s 0 dpms -nocursor -nolisten tcp "$@"' >> /etc/X11/xinit/xserverrc

#
# Install dependencies 
#

RUN apt-get install --no-install-recommends -y \ 
   dbus-x11 \
   xserver-xorg-legacy \
   xserver-xorg-input-synaptics \
   xserver-xorg-input-evdev \
   xserver-xorg-input-mouse \
   x11-xserver-utils \
   xserver-xorg-video-all \
   xserver-common \
   usbutils \
   && apt-get autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*

#
# Add mouse support
#

#ADD 10-input.conf /etc/X11/xorg.conf.d/
#ADD 40-libinput.conf /etc/X11/xorg.conf.d/
ADD 45-evdev.conf /etc/X11/xorg.conf.d/
#ADD 99-fbturbo.conf /etc/X11/xorg.conf.d/
ADD 99-calibration.conf /etc/X11/xorg.conf.d/

#
# Set user to pi
#
RUN usermod -a -G input pi 
#USER pi # if commented then touchscreen works?
WORKDIR /home/pi

CMD ["bash", "start.sh"]




# FROM ubuntu:18.04

# # Install dependencies 
# RUN apt-get update && apt-get install --no-install-recommends -y \ 
#    xserver-xorg-video-all \
#    xserver-xorg-input-libinput \
#    xserver-xorg-input-synaptics \
#    xserver-xorg-input-evdev \
#    xserver-xorg-input-multitouch \
#    xserver-xorg-input-mouse \
#    xserver-xorg-input-all \
#    xserver-xorg-core \
#    xserver-xorg \
#    xserver-xorg-legacy \
#    xinit \
#    x11-xserver-utils \
#    dbus-x11 \
#    unclutter \
#    chromium-browser

# #console auutologin (via raspi-cconfig)

# #ADD PI user
# RUN useradd -ms /bin/bash pi
# RUN usermod -a -G tty pi

# #add files 
# ADD start.sh /home/pi/
# ADD .xinitrc /home/pi/
# ADD Xwrapper.config /etc/X11/
# RUN mkdir -p /etc/X11/xorg.conf.d && cp /usr/share/X11/xorg.conf.d/40-libinput.conf /etc/X11/xorg.conf.d/40-libinput.conf

# # Clear cache
# RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# # Set user to pi
# USER pi
# WORKDIR /home/pi

# CMD ["bash", "start.sh"]
