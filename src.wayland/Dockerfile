ARG OS_VERSION=ubuntu:22.04
FROM ${OS_VERSION}

ARG BROWSER=firefox-esr
ENV BROWSER=${BROWSER}
#
# User Actions
#

ENV USER=${USER:-display}
RUN useradd -ms /bin/bash ${USER} && \
    usermod -a -G video ${USER} && \
    usermod -a -G tty ${USER}

#
# Install core 
#

RUN ln -snf "/usr/share/zoneinfo/${TZ:-Europe/Amsterdam}" /etc/localtime \
#    && mkdir -p /etc/X11/xorg.conf.d \
    && mkdir -p /etc/xdg/weston \
    && mkdir -p /var/log/supervisor \
    && echo "${TZ:-Europe/Amsterdam}" > /etc/timezone \
    && apt-get update \
    && apt install -y software-properties-common \
    && add-apt-repository -y ppa:mozillateam/ppa \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get  install --no-install-recommends -y \
        wayland \
        weston \
        unclutter \
        ${BROWSER} \
        mosquitto-clients \
        supervisor \
    && apt-get purge -y software-properties-common \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

#
# Add files
#
RUN --mount=type=bind,source=./,target=/mnt \
    cd /mnt \
 #   && cp .xserverrc /home/${USER}/ \
 #   && cp .xinitrc /home/${USER}/ \
    && cp display-power.sh /home/${USER}/ \
    && cp mqtt.sh /home/${USER}/ \
 #   && cp 99-calibration.conf /etc/X11/xorg.conf.d/ \
    && cp weston.conf /etc/supervisor/conf.d/ \
 #   && cp 45-evdev.conf /etc/X11/xorg.conf.d/ \
 #   && cp Xwrapper.config /etc/X11/ \
    && cp weston.ini /etc/xdg/weston/ \
    && cp start.sh /home/${USER}/ \
    && cp supervisord.conf /etc/supervisor/supervisord.conf \
    && if [ "$BROWSER" = 'chromium' ]; then \
        mkdir -p /home/${USER}/.config/chromium/Default /etc/chromium/policies/managed \
        && cp chromium/policies.json /etc/chromium/policies/managed/ \
        && cp chromium/Pref /home/${USER}/.config/chromium/Default/ \
        && cp chromium/chromium.conf /etc/supervisor/conf.d/; \
    elif [ "$BROWSER" = 'firefox-esr' ]; then \
        mkdir -p /home/${USER}/.mozilla/firefox/ \
        && cp firefox/99-calibration.conf /etc/X11/xorg.conf.d/ \        
        && cp firefox/firefox.conf /etc/supervisor/conf.d/firefox.conf \
        && cp firefox/mozilla.cfg /usr/lib/firefox-esr/ \
        && cp firefox/autoconfig.js /usr/lib/firefox-esr/defaults/pref/ \
        && cp firefox/policies.json /usr/lib/firefox-esr/distribution/ \
        && cp firefox/profiles.ini /home/${USER}/.mozilla/firefox/; \
    fi \
    && chmod +x /home/${USER}/*.sh  \
    && chmod 0750 /home/${USER}/.x*  \
#    && usermod -a -G input ${USER} \
#    && echo export -p DISPLAY="\$(ps -aux | grep Xorg| grep -Po '(?<= )(:[0-9]+)(?=\ )')" | tee -a /home/${USER}/.bashrc \
    && chown ${USER}:${USER} -R /home/${USER}


ENV WIDTH=1024
ENV HEIGHT=600

USER ${USER:-display}
WORKDIR /home/${USER:-display}

VOLUME /home/${USER:-display}/.config/chromium
VOLUME /home/${USER:-display}/.mozilla




#CMD ["bash", "start.sh"]
#CMD ["tail", "-f","/dev/null"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]
