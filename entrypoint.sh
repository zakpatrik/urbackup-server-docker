#!/bin/bash

chown urbackup:urbackup /media/BACKUP/urbackup
chown urbackup:urbackup /var/urbackup
exec urbackupsrv "$@"
