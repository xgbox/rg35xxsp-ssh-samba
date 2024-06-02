#!/bin/bash

# Disables Samba
systemctl stop smbd
systemctl disable smbd
systemctl stop nmbd
systemctl disable nmbd

