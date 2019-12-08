ARG IMAGE_ARCH=debian:stretch
FROM ${IMAGE_ARCH}

ENV DEBIAN_FRONTEND=noninteractive
ARG VERSION=2.4.11
ENV VERSION ${VERSION}
ARG ARCH=amd64
ARG QEMU_ARCH
ENV FILE urbackup-server_${VERSION}_${ARCH}.deb
ENV URL https://hndl.urbackup.org/Server/${VERSION}/${FILE}

COPY entrypoint.sh qemu-${QEMU_ARCH}-static* /usr/bin/
ADD ${URL} /root/${FILE}

RUN apt-get update \
        && echo "urbackup-server urbackup/backuppath string /backups" | debconf-set-selections \
        && echo "/var/urbackup" | apt-get install -y /root/${FILE} \
        && rm /root/${FILE} \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

RUN mkdir /web-backup && cp -R /usr/share/urbackup/* /web-backup
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 55413
EXPOSE 55414
EXPOSE 55415
EXPOSE 35623/udp

VOLUME [ "/var/urbackup", "/var/log", "/backups" ]
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["run"]
