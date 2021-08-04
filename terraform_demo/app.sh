#!/bin/bash

# Set Logging Options
set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1
echo BEGIN
date '+%Y-%m-%d %H:%M:%S'

#update system
yum update -y

#set hostname
hostnamectl set-hostname app.YOURDOMAIN.internal

#wait for ebs mount
while [ -f /dev/xvdh ] ; do sleep 1 ; done

# make volume group active & scan for errors
#vgchange -ay vg01
#lvscan

# set SELINUX to permissive 
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config

# get masterless salt repo and apply basic config 
cd /root/ && git clone git@github.com:travismoran/cfc-salt-master.git
rm -rf /srv/salt
ln -s /root/cfc-salt-master /srv/salt
#salt-call --local state.apply

# load updated systemd config & restart docker 
systemctl daemon-reload
systemctl restart docker

# clone docker-compose repo 
#cd /data01 && rm -rf docker-compose
#cd /data01 && git clone git@github.com:travismoran/docker-compose.git

# Install docker-compose mariadb systemd service
#cd /data01/docker-compose/demo_mariadb && dcsg install docker-compose.yml

#configure and start salt minion 
echo id: $(hostname) >> /etc/salt/minion
echo master: saltmaster.YOURDOMAIN.internal >> /etc/salt/minion
echo hash_type: sha256 >> /etc/salt/minion
systemctl enable salt-minion.service
systemctl restart salt-minion.service

#post config reboot
(crontab -l 2>/dev/null; echo "@reboot /usr/bin/salt-call --local state.apply") | crontab -
shutdown -r now
