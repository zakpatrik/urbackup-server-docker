#!/bin/bash

cp -R /web-backup/* /usr/share/urbackup
echo "/backups" > /var/urbackup/backupfolder
usermod -u $PUID -o urbackup
groupmod -g $PGID -o urbackup
chown urbackup:urbackup /backups
chown urbackup:urbackup /var/urbackup
exec urbackupsrv "$@"
