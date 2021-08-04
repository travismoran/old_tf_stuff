#!/bin/bash
yum -y clean all
yum -y update
yum -y clean all
chmod 700 /home/centos/.ssh
chmod 640 /home/centos/.ssh/*