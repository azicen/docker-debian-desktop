FROM ghcr.io/linuxserver/baseimage-debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive \
    WINDOWMANAGER=openbox \
    LANG=C \
    DISPLAY=:0 \
    VNC_TITLE=TigerVNC \
    VNC_HOST=127.0.0.1 \
    VNC_PORT=5901 \
    VNC_GEOMETRY=1280x800 \
    NOVNC_HOST=0.0.0.0 \
    NOVNC_PORT=6081 \
    HOME=/config

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen && \
    mkdir -p /usr/share/man/man1 && \
    chsh -s /bin/bash abc

RUN apt update && \
    apt install -y --no-install-recommends \
        iputils-ping \
        iproute2 \
        procps \
        grep \
        sudo \
        dbus-x11 \
        xfonts-base \
        x11-utils \
        x11-xserver-utils \
        tigervnc-common \
        tigervnc-standalone-server \
        tigervnc-tools \
        xterm \
        openbox \
        novnc \
        fonts-noto-cjk && \
    apt autoremove -y && \
    apt autoclean -y && \
    apt clean && \
    rm -rf \
        /config/.cache \
        /config/.launchpadlib \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/*

COPY /root /
RUN chmod +x /etc/s6-overlay/s6-rc.d/*/run

EXPOSE 5901 6081
VOLUME /config
