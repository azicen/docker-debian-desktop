FROM ghcr.io/linuxserver/baseimage-debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive \
    WINDOWMANAGER=openbox \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    DISPLAY=:0 \
    VNC_TITLE=TigerVNC \
    VNC_HOST=127.0.0.1 \
    VNC_PORT=5901 \
    VNC_GEOMETRY=1280x800 \
    NOVNC_HOST=0.0.0.0 \
    NOVNC_PORT=6081 \
    HOME=/config

RUN apt update && \
    apt install -y --no-install-recommends \
        at-spi2-core \
        build-essential \
        dbus \
        grep \
        iputils-ping \
        iproute2 \
        openbox \
        procps \
        sudo \
        tigervnc-standalone-server \
        fonts-wqy-zenhei \
        xterm \
        wget \
        novnc && \
    echo 'abc ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
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
