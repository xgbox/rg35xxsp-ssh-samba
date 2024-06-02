#!/bin/bash

progdir=$(dirname "$0")
G_DIR="/mnt/mod/ctrl/configs"
G_CONF="${G_DIR}/system.cfg"
if [ ! -d ${G_DIR} ]
then
    mkdir -p ${G_DIR}
fi
touch ${G_CONF}

# Removes global.ssh flag from system.cfg
sed -i '/global.ssh=/d' "${G_CONF}"

# Stops SSH now
systemctl stop ssh.service
systemctl disable ssh.service
