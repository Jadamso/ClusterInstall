#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"
source "EnvironmentSetup.sh"

#------------------------------------------------------------------
#########################
# Bash Parallel Programs
#########################
#https://www.gnu.org/software/parallel/parallel_tutorial.html#GNU-Parallel-Tutorial

echo -e "$s0 GNU parallel... $s1"

cd ~
vers= #20170622
wget http://ftpmirror.gnu.org/parallel/parallel-$vers.tar.bz2
tar xvfj parallel-$vers.tar.bz2  && rm parallel-$vers.tar.bz2
vers=$(tar -tzvf parallel-latest.tar.gz | head -1 | awk '{print $NF}')
cd parallel-$vers
./configure --prefix=$HOME
make
$SUDO make install

#sudo $(wget -O - pi.dk/3 || curl pi.dk/3/ || fetch -o - http://pi.dk/3) | bash
#cp $(which parallel) $PREFIX/bin/parallel

#------------------------------------------------------------------
#########################
# BASH Shell
#########################
vers=4.4
cd ~ && wget https://ftp.gnu.org/gnu/bash/bash-$vers.tar.gz
tar -xzf bash-$vers.tar.gz && rm bash-$vers.tar.gz
cd ~/bash-$vers
./configure --prefix=$HOME
make 
$SUDO make install

#------------------------------------------------------------------
#########################
# CURL
#########################
## libcurl

#sudo yum install -y curl-devel

# For HTTPS Support
## First install SSHSetup.sh to add https support
#or
#sudo yum -y install \
#	openssl098e.x86_64 \
#	openssl-libs.x86_64 \
#	openssl-devel.x86_64



vers=7.54.0
cd ~ && wget --no-check-certificate "https://curl.haxx.se/download/curl-$vers.tar.gz"
tar xzvf curl-$vers.tar.gz && rm curl-$vers.tar.gz
cd ~/curl-$vers
./configure --with-ssl --prefix=$HOME 
make
$SUDO make install


#------------------------------------------------------------------
#########################
# TREE
#########################

cd ~
vers=1.7.0
wget ftp://mama.indstate.edu/linux/tree/tree-$vers.tgz
tar zxf tree-$vers.tgz && rm tree-$vers.tgz
cd tree-$vers
make
$SUDO cp ~/tree-$vers/tree ~/bin

exit

#------------------------------------------------------------------
#########################
# gnutls
#########################
#vers=3.5.9
#cd ~ 
#wget https://www.gnupg.org/ftp/gcrypt/gnutls/v3.5/gnutls-#$vers.tar.xz
#tar xf gnutls-$vers.tar.xz && rm gnutls-$vers.tar.xz
#cd ~/gnutls-$vers
#./configure --prefix=$HOME
#make 
#$SUDO make install

#------------------------------------------------------------------
#########################
# WGET
#########################

vers=1.19
cd ~ && wget https://ftp.gnu.org/gnu/wget/wget-$vers.tar.xz
tar -xf wget-$vers.tar.xz && rm wget-$vers.tar.xz
cd ~/wget-$vers
./configure \
    --prefix=$HOME \
    --without-gnutils
make 
$SUDO make install
#wants LIBPSL GNUTLS
#------------------------------------------------------------------
#########################
# MAKE 
#########################

#------------------------------------------------------------------
#########################
# CMAKE 
#########################

cd ~ 
vers=3.9
versa=$vers.0
wget https://cmake.org/files/v$vers/cmake-$versa-rc2.tar.gz
tar xzvf cmake-$versa-rc2.tar.gz && rm cmake-$versa-rc2.tar.gz
cd cmake-$versa-rc2
./configure --prefix=$HOME 
gmake
$SUDO make install




exit

