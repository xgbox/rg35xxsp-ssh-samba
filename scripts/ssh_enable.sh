#!/bin/bash

progdir=$(dirname "$0")
G_DIR="/mnt/mod/ctrl/configs"
G_CONF="${G_DIR}/system.cfg"
if [ ! -d ${G_DIR} ]
then
    mkdir -p ${G_DIR}
fi
touch ${G_CONF}

#Adds global.ssh=1 flag to system.config
sed -i '/global.ssh=/d' "${G_CONF}"
echo "global.ssh=1" >> "${G_CONF}"

#Start SSH service
systemctl enable ssh.service
systemctl start ssh.service
