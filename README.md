## Multiarch (amd64/armhf/aarch64) docker images for UrBackup server.
Pulling the :latest tag should automatically grab the right image for your arch.

Most of the original code is based on the image by [Whatang](https://github.com/Whatang/docker_urbackup)


## Running

If you want to use docker run command:

`docker run -d --name urbackup -v /path/to/your/backup/folder:/media/BACKUP/urbackup -v /path/to/your/database/folder:/var/urbackup --network host morlan/urbackup_docker:latest`

Or via docker-compose: 

`docker-compose.yml`
```
version: '2'

services:
        urbackup:
                image: morlan/urbackup_docker:latest
                container_name: urbackup
                restart: unless-stopped
                volumes:
                        - /path/to/your/database/folder:/var/urbackup
                        - /path/to/your/backup/folder:/backups
               network_mode: "host"
	       # Activate privileged mode for BTRFS support
	       #privileged: true
```              
	     
After running the container Urbackup should be reachable on the web interface on port :55414	     
