#!/bin/bash

################################################
#
# baremetal-backup.sh -	This is an online bare metal
#			backup script.
#
# Author: Ryan Patrick Murphy <Twitter: @RyChannel>
#
# Atrribute:
# This script is based on code found in WC Preston's book
# "Backup & Recovery: Inexpensive Backup Solutions for Open Systems"
#
################################################				

#Server and share you will be backing up to.
nfsserver="10.0.1.1"
nfsshare="/server01/backups"

#local folder the nfs share will be mounted on. Folder shouldn't exist.
localfolder="/backups"

#It would be a good idea to mount the nfs share each time the script runs

mkdir $localfolder
mount $nfsserver:$nfsshare $localfolder

#Copy /etc/fstab so you can reference it for the restore
cp /etc/fstab $localfolder/fstab

#Backup the MBR

dd if=/dev/sda of=$localfolder/mbr bs=512 count=1

#Backup the operating system

tar cfz $localfolder/boot.tar.gz /boot

tar cfz $localfolder/system.tar.gz --exclude /mnt --exclude /proc --exclude /boot --exclude $localfolder .

#unmount the backup share and remove the mount folder

umount $localfolder
rm -r $localfolder
