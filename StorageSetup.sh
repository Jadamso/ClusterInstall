#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"


#########################
# fpsync
#########################

cd ~ 
git clone https://github.com/martymac/fpart.git
cd fpart
autoreconf -i 
./configure --prefix=$HOME && make 
sudo make install


#########################
# DropBox
#########################

yum -y install nautilus-devel.x86_64 

wget "https://linux.dropbox.com/packages/nautilus-dropbox-2015.02.12.tar.bz2"
tar xjf ./nautilus-dropbox-2015.02.12.tar.bz2
rm ./nautilus-dropbox-2015.02.12.tar.bz2
cd ./nautilus-dropbox-2015.02.12; ./configure; make; sudo make -j4 install;


# GitHub
#yum install git-all.noarch
#curl https://codeload.github.com/hpc12/tools/tar.gz/master | tar xvfz -
#rpm -Uvh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm






#########################
# AWS 
#########################
## Amazon Web Services

# http://docs.aws.amazon.com/cli/latest/userguide/installing.html
# https://console.aws.amazon.com/iam/home?#/home
yum -y install awscli.noarch

## Manually Download Key
## chmod 400 ~/Downloads/AWS-key.pem && cp ~/Downloads/AWS-key.pem ~/.ssh/AWS-key.pem


