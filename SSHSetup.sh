#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"

#########################
# OpenSSL
#########################

cd ~
git clone https://github.com/openssl/openssl.git
cd openssl
./config --prefix=$HOME
make
$SUDO make install

#########################
# OpenSSH
#########################

#https://github.com/openssh/openssh-portable.git
vers=7.5p1
cd ~
wget http://mirror.jmu.edu/pub/OpenBSD/OpenSSH/portable/openssh-$vers.tar.gz
tar -xzf  openssh-$vers.tar.gz && rm openssh-$vers.tar.gz
cd ~/openssh-$vers
./configure --prefix=$HOME && make 
$SUDO make install
echo $(ssh -V)


#########################
# SSH Pass
#########################

## manual: http://downloads.sourceforge.net/project/sshpass/sshpass/1.05/sshpass-1.05.tar.gz
