#!/bin/bash

# Set Logging Options
set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1
echo BEGIN
date '+%Y-%m-%d %H:%M:%S'

#update system
yum update -y

#set hostname
hostnamectl set-hostname saltmaster.YOURDOMAIN.internal

#wait for ebs mount
while [ -f /dev/xvdh ] ; do sleep 1 ; done

# make volume group active & scan for errors
#vgchange -ay vg01
#lvscan

# set SELINUX to permissive 
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config

# clone docker-compose repo 
#cd /data01 && rm -rf docker-compose
#cd /data01 && git clone git@github.com:travismoran/docker-compose.git

# get masterless salt repo and apply basic config 
cd /root/ && git clone git@github.com:travismoran/cfc-salt-master.git
rm -rf /srv/salt
ln -s /root/cfc-salt-master /srv/salt
#salt-call --local state.apply

# load updated systemd config & restart docker 
systemctl daemon-reload
systemctl restart docker

# Install docker-compose mariadb systemd service
#cd /data01/docker-compose/demo_mariadb && dcsg install docker-compose.yml



#configure and start salt minion 
echo id: $(hostname) >> /etc/salt/minion
echo master: saltmaster.YOURDOMAIN.internal >> /etc/salt/minion
echo hash_type: sha256 >> /etc/salt/minion
systemctl enable salt-minion.service
systemctl restart salt-minion.service

# Run salt-call --local state.apply at startup
/usr/bin/salt-call --local state.apply

# start salt master
systemctl enable salt-master.service
service salt-master start
systemctl restart salt-master.service

#post config reboot
(crontab -l 2>/dev/null; echo "@reboot /usr/bin/salt-call --local state.apply") | crontab -
shutdown -r now
#docker run -d --restart=unless-stopped -p 8080:8080 rancher/server --db-host 172.28.3.5 --db-port 3306 --db-user rancher --db-pass RANCHERDBPASS --db-name rancher
#echo id: $(hostname) >> /etc/salt/minion
#echo master: saltmaster.YOURDOMAIN.internal >> /etc/salt/minion
#echo hash_type: sha256 >> /etc/salt/minion

#systemctl enable salt-minion.service
#systemctl restart salt-minion.service
