#!/bin/bash

# Install Samba if not installed
if [ ! -f /lib/systemd/system/smbd.service ]; then
    # If Samba not installed, check for Internet; exits 1 if it can't ping Google
    ping -c 1 google.com > /dev/null 2>&1
    # Check the exit status of the ping command
    if [ $? -ne 0 ]; then
        echo "No internet connection."
        exit 1
    else
        echo "Internet connection is active."
        apt-get update
        apt-get install -y samba-client samba-common python-glade2 system-config-samba
    fi


fi

systemctl enable smbd 
systemctl start smbd
systemctl enable nmbd
systemctl start nmbd

# Back up existing /etc/samba/smb.conf only if there isn't already one
if [ ! -f /etc/samba/smb.conf.bak ]; then
    if [ -f /etc/samba/smb.conf ]; then
        mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
    fi
fi

# Generate smb.conf
cat > /etc/samba/smb.conf << EOF
    [global]
    workgroup = WORKGROUP
    server string = Samba Server %v
    netbios name = ubuntu
    admin users = root
    security = user
    name resolve order = bcast host
    dns proxy = no

    [__root]
    comment = OS Root directory
    path = /
    browsable = yes
    writable = yes
    guest ok = no
    read only = no
    create mode = 0755
    directory mode = 0755
    force user = nobody

    [__sdcard]
    comment = SD slot 1: top level
    path = /mnt/mmc
    browsable = yes
    writable = yes
    guest ok = no
    read only = no
    create mode = 0755
    directory mode = 0755
    force user = nobody

    [__sdcard2]
    comment = SD slot 2: top level
    path = /mnt/sdcard
    browsable = yes
    writable = yes
    guest ok = no
    read only = no
    create mode = 0755
    directory mode = 0755
    force user = nobody

EOF

# Restart Samba services
systemctl restart smbd.service nmbd.service

# Set account to use for logging in to network share
user=root
pass=root

(echo "$pass"; echo "$pass") | smbpasswd -s -a "$user"