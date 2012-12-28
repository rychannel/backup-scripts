#!/bin/bash


####################################################
#
# baremetal-restore.sh - Restore's baremetal-backup. 
#			This script requires a live cd such as knoppix or 
#			finnix.
#			Review the entire script for needed modifications 
#			to fit your situation. This script assumes that
#			you performed a bare metal backup using my
#			bare metal backup script.
#
# Author: Ryan Patrick Murphy <Twitter: @Rychannel>
#
# Inspired by WC Preston's book:
# "Backup and Recovery: Inexpensive Backup Solutions for Open Systems"
####################################################

destdrive=sda

#Folder NFS share will mount
backupmount=/backups

#NFS Server address and share
nfsserver=10.0.1.10
nfsshare=/server01/backups

#Restore MBR and Partition Table
dd if=$backupmount/mbr of=/dev/$destdrive bs=512 count=1

#Create the filesystems for each partition referenced in fstab
#
# mkfs -t ext2 /dev/${destdrive}1 -L /boot
# mkfs -t ext4 /dev/${destdrive}2 -L /

#Restore the operating system
#Mount the available partitions, except the swap partition
#
# mkdir /mnt/${destdrive}1
# mount /dev/${destdrive}1 /mnt/${destdrive}1
# mkdir /mnt/4{destdrive}2
# mount /dev/4{destdrive}2 /mnt/${destdrive}2

##Restore files to their proper partitions
#
#Use these lines if you have seperate partitions for /boot and /.
#If you have additional partitions(besides swap) you will need to add
#additional lines.
#
# cd /mnt/${destdrive}1
# tar xpkfz /${backupmount}/boot.tar.gz
# cd /mnt/${destdrive}2
# tar xpkfz /${backupmount}/system.tar.gz
#
#If your /boot is on the same partition as / then use these lines
#Modify the partition number to match the partition specified in fstab
#
# cd /mnt/${destdrive}1
# tar xpkfz /${backupmount}/system.tar.gz
# mkdir boot
# cd boot
# tar xpkfz /${backupmount}/boot.tar.gz


echo "Remove the live cd and reboot your system."
