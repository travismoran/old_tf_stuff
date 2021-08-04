#!/bin/bash

# Set Logging Options
set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1
echo BEGIN
date '+%Y-%m-%d %H:%M:%S'

#update system
apt-get update -y

#set hostname
hostnamectl set-hostname nginx03.YOURDOMAIN.internal

docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  -v /efs/nginx/nginx01.conf:/etc/nginx/nginx.conf \
  nginx:1.14
  
#wait for ebs mount
#while [ -f /dev/xvdh ] ; do sleep 1 ; done
#
## make volume group active & scan for errors
#vgchange -ay vg01
#lvscan

# set SELINUX to permissive 
#setenforce 0
#sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config

# get masterless salt repo and apply basic config 
#cd /root/ && git clone git@github.com:travismoran/cfc-salt-master.git
#rm -rf /srv/salt
#ln -s /root/rancher-salt /srv/salt
#salt-call --local state.apply
#
## load updated systemd config & restart docker 
#systemctl daemon-reload
#systemctl restart docker
#
## clone docker-compose repo 
#cd /data01 && git clone git@github.com:travismoran/docker-compose.git
#
## Install docker-compose mariadb systemd service
##cd /data01/docker-compose/demo_mariadb && dcsg install docker-compose.yml
#
##configure and start salt minion 
#echo id:$(hostname) >> /etc/salt/minion
#echo master:$(hostname) >> /etc/salt/minion
#echo hash_type: sha256 >> /etc/salt/minion
#systemctl enable salt-minion.service
#systemctl restart salt-minion.service

