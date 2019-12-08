#!/bin/bash
# Copy www-folder back, if folder is bind-mounted
cp -R /web-backup/* /usr/share/urbackup
# Specifying backup-folder location
echo "/backups" > /var/urbackup/backupfolder
# Giving the user and group "urbackup" the provided UID/GID
usermod -u $PUID -o urbackup
groupmod -g $PGID -o urbackup
chown urbackup:urbackup /backups
chown urbackup:urbackup /var/urbackup
exec urbackupsrv "$@"
