ARG OS_VERSION=debian:bookworm
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
ARG BROWSER=chromium
RUN ln -snf "/usr/share/zoneinfo/${TZ:-Europe/Amsterdam}" /etc/localtime \
    && mkdir -p /etc/X11/xorg.conf.d \
    && mkdir -p /var/log/supervisor \
    && echo "${TZ:-Europe/Amsterdam}" > /etc/timezone \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get install --no-install-recommends -y \
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
        supervisor \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

#
# Add files
#
RUN --mount=type=bind,source=./,target=/mnt \
    cd /mnt \
    && cp .xserverrc /home/display/ \
    && cp .xinitrc /home/display/ \
    && cp display-power.sh /home/display/ \
    && cp mqtt.sh /home/display/ \
    && cp 99-calibration.conf /etc/X11/xorg.conf.d/ \
    && cp 45-evdev.conf /etc/X11/xorg.conf.d/ \
    && cp Xwrapper.config /etc/X11/ \
    && cp start.sh /home/display/ \
    && cp supervisord.conf /etc/supervisor/conf.d/supervisord.conf \
    && if [ "$BROWSER" = 'chromium' ]; then \
        mkdir -p /home/display/.config/chromium \
        && cp chromium/policies.json /etc/chromium/policies/managed/ \
        && cp chromium/Pref /home/display/.config/chromium/Default/ \
        && cp chromium/chromium.conf /etc/supervisor/conf.d/; \
    elif [ "$BROWSER" = 'firefox' ]; then \
        cp firefox/firefox.conf /etc/supervisor/conf.d/firefox.conf \
        && cp firefox/mozilla.cfg /usr/lib/firefox-esr/ \
        && cp firefox/autoconfig.js /usr/lib/firefox-esr/defaults/pref/ \
        && cp firefox/policies.json /usr/lib/firefox-esr/distribution/ \
        && cp firefox/profiles.ini /home/neko/.mozilla/firefox/; \
    fi \
    && chmod +x /home/display/*.sh  \
    && chmod 0750 /home/display/.x*  \
    && usermod -a -G input display \
    && chown display:display -R /home/display/

WORKDIR /home/display
VOLUME /home/display/.config/chromium
USER display

#CMD ["bash", "start.sh"]
#CMD ["tail", "-f","/dev/null"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
