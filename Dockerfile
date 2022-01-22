# Base image can be specified by --build-arg IMAGE_ARCH= ; defaults to debian:buster
ARG IMAGE_ARCH=debian:buster
FROM ${IMAGE_ARCH}

ENV DEBIAN_FRONTEND=noninteractive
ARG VERSION=2.4.15
ENV VERSION ${VERSION}
ARG TARGETPLATFORM

COPY entrypoint.sh /usr/bin/

RUN case ${TARGETPLATFORM} in \
         "linux/amd64")  URL=https://hndl.urbackup.org/Server/${VERSION}/debian/buster/urbackup-server_${VERSION}_amd64.deb  ;; \
         "linux/arm64")  URL=https://hndl.urbackup.org/Server/${VERSION}/urbackup-server_${VERSION}_arm64.deb  ;; \
         "linux/arm/v7") URL=https://hndl.urbackup.org/Server/${VERSION}/urbackup-server_${VERSION}_armhf.deb  ;; \
         "linux/386")    URL=https://hndl.urbackup.org/Server/${VERSION}/debian/buster/urbackup-server_${VERSION}_i386.deb   ;; \
    esac \
        && apt-get update \
        && apt-get install -y wget \
        && wget -q "$URL" -O /root/urbackup-server.deb \
        && echo "urbackup-server urbackup/backuppath string /backups" | debconf-set-selections \
        && apt-get install -y --no-install-recommends /root/urbackup-server.deb btrfs-tools \
        && rm /root/urbackup-server.deb \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

# Backing up www-folder
RUN mkdir /web-backup && cp -R /usr/share/urbackup/* /web-backup
# Making entrypoint-script executable
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 55413
EXPOSE 55414
EXPOSE 55415
EXPOSE 35623/udp

# /usr/share/urbackup will not be exported to a volume by default, but it still can be bind mounted
VOLUME [ "/var/urbackup", "/var/log", "/backups" ]
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["run"]
