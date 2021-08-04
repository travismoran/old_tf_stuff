#!/bin/bash
set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1
echo BEGIN
date '+%Y-%m-%d %H:%M:%S'

apt-get -y update
apt-get -y install git
#chmod 600 /root/.ssh/*
#curl https://releases.rancher.com/install-docker/18.09.sh | sh
#curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#chmod +x /usr/local/bin/docker-compose
#curl -L https://github.com/andreaskoch/dcsg/releases/download/v0.4.0/dcsg_linux_amd64 > /usr/local/bin/dcsg
#chmod +x /usr/local/bin/dcsg
ssh-keyscan bitbucket.org >> ~/.ssh/known_hosts
#cd /root/ && git clone git@github.com:travismoran/rancher-dev01-DOMAIN.git
#cd /root/rancher-dev01-DOMAIN/
mkdir -p /data01 
echo '/dev/xvdh /data01 ext4 defaults,nofail 0 0' >> /etc/fstab
mount -a
cd /data01/rancher-dev01-DOMAIN/
dcsg install docker-compose.yml
systemctl daemon-reload
systemctl enable rancher-dev01-DOMAIN
systemctl start rancher-dev01-DOMAIN
sleep 15
docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.2.11 https://rancher.DOMAIN.com/v1/scripts/KEY:KEY:KEY