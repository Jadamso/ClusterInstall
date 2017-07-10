#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"

#########################
# Rsync 
#########################

cd ~ 
vers=3.1.2
wget https://download.samba.org/pub/rsync/rsync-$vers.tar.gz
tar xzvf rsync-$vers.tar.gz && rm rsync-$vers.tar.gz
cd rsync-$vers
./configure --prefix=$HOME 
make
$SUDO make install

exit 

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

rclone config 
#new remote
#local 
#name=GoogleDrive
# google drive
# jadamso@g.clemson.edu

