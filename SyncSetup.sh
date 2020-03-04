#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"
source "EnvironmentSetup.sh"

#------------------------------------------------------------------
#########################
# Rsync 
#########################

cd ~ 
vers=3.1.2
wget https://download.samba.org/pub/rsync/rsync-$vers.tar.gz
tar xzvf rsync-$vers.tar.gz && rm rsync-$vers.tar.gz
cd rsync-$vers
./configure --prefix=$PREFIX 
make
$SUDO make install

#------------------------------------------------------------------
#########################
# Rclone 
#########################
#http://rclone.org/install/

#cd ~
#git clone https://github.com/ncw/rclone.git
#cd rclone
#make 

cd ~
vers=v1.36
curl -O https://downloads.rclone.org/rclone-$vers-linux-amd64.zip
unzip rclone-$vers-linux-amd64.zip && rm rclone-$vers-linux-amd64.zip
cd rclone-$vers-linux-amd64

$SUDO cp rclone /usr/sbin/
$SUDO chown root:root /usr/sbin/rclone
$SUDO chmod 755 /usr/sbin/rclone

$SUDO mkdir -p /usr/local/share/man/man1
$SUDO cp rclone.1 /usr/local/share/man/man1/
$SUDO mandb

#------------------------------------------------------------------
###################
# Installation
###################


## https://rclone.org/drive/


echo "rclone config"
#new remote
#local 
#name=GoogleDrive
# 7 < google drive
#
#
# (USE ACADEMIC EMAIL - free storage)




# http://www.pcworld.com/article/3170896/linux/how-to-easily-keep-your-cloud-files-private-with-rclone.html

## Download
#rclone sync remote:path /path/to/folder

## Upload
#rclone sync /path/to/folder remote:$inpath

#------------------------------------------------------------------
###################
# Other Programs
###################

# Split directory into equi-sized ``parts''
# https://github.com/martymac/fpart


## Copy to Mulitple Destinations
# parallel-rsync
# prsync 
# fpsync -n 4 -f 1000 -s $((100 * 1024 * 1024))


## http://www.cis.upenn.edu/~bcpierce/unison/index.html

## Watches File and Automatically Rsync 
#https://github.com/axkibe/lsyncd

## Watches File and Automatically Rclone
#https://hub.docker.com/r/aguamala/clonetocloud/

## Cloud Storage Syncing
#https://github.com/syncthing/syncthing


# Large data transfers thru fast network (>1Gb/s).
#http://moo.nac.uci.edu/~hjm/parsync/
#parsync --NP=4  --rsyncopts='--compress' --startdir=/usr  local /media/backupdisk


