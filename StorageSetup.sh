#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"
source "EnvironmentSetup.sh"

#------------------------------------------------------------------
#########################
# fpart
#########################

cd ~ 
git clone https://github.com/martymac/fpart.git
cd fpart
autoreconf -i 
./configure --prefix=$PREFIX && make 
sudo make install


#------------------------------------------------------------------
#########################
# DropBox Manual Install 
#########################
# https://www.dropbox.com/help/desktop-web/linux-commands

vers=1.6.0
wget https://linux.dropbox.com/packages/nautilus-dropbox-$vers.tar.bz2
tar xvjf nautilus-dropbox-$vers.tar.bz2 &&  rm nautilus-dropbox-$vers.tar.bz2
cd ./nautilus-dropbox-$vers
./configure

make; make install;

## GUI requires libnautilus-extension
#echo https://linux.dropbox.com/packages/
#vers=2.10.0
#wget "https://linux.dropbox.com/packages/nautilus-dropbox-$vers.tar.bz2"
#tar xjf ./nautilus-dropbox-$vers.tar.bz2
#rm ./nautilus-dropbox-$vers.tar.bz2
#cd ./nautilus-dropbox-$vers
#./configure
#make
#sudo make -j4 install

#------------------------------------------------------------------
#########################
# DropBox AutoInstall Headless
#########################

## Download
cd ~ 
wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

## Initiate
~/.dropbox-dist/dropboxd

## Selective Sync:
#https://www.dropbox.com/help/syncing-uploads/selective-sync-overview
wget -O ~/.dropbox-dist/dropbox.py  'https://www.dropbox.com/download?dl=packages/dropbox.py'
chmod +x dropbox.py
# ~/.dropbox-dist/dropbox.py exclude add ~/Dropbox/Paper_*/Data

#dnf -y install nautilus-devel.x86_64 dropbox

#------------------------------------------------------------------
#########################
# AWS 
#########################
## Amazon Web Services

# http://docs.aws.amazon.com/cli/latest/userguide/installing.html
# https://console.aws.amazon.com/iam/home?#/home
yum -y install awscli.noarch

## Manually Download Key
## chmod 400 ~/Downloads/AWS-key.pem
## cp ~/Downloads/AWS-key.pem ~/.ssh/AWS-key.pem
## rm ~/Downloads/AWS-key.pem

#------------------------------------------------------------------
#########################
# GitHub
#########################
#yum install git-all.noarch
#curl https://codeload.github.com/hpc12/tools/tar.gz/master | tar xvfz -
#rpm -Uvh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm

