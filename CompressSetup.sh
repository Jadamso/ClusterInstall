#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"
source "EnvironmentSetup.sh"

#------------------------------------------------------------------
#########################
# zlib
#########################
## Pre install for R
# http://pj.freefaculty.org/blog/?p=315

echo -e "$s00 zlib $s1"
vers=1.2.11
cd ~ && wget "http://zlib.net/zlib-$vers.tar.gz"
tar -xzf zlib-$vers.tar.gz && rm zlib-$vers.tar.gz
cd $HOME/zlib-$vers
./configure --prefix=$PREFIX
make
$SUDO make install
#https://github.com/madler/zlib.git

#------------------------------------------------------------------
#########################
# bzip2
######################### 
## Already comes with linux

#echo -e "$s00 bzip2 $s1"
#vers=1.0.6
#cd ~ && wget "http://www.bzip.org/$vers/bzip2-$vers.tar.gz"
#tar xzvf bzip2-$vers.tar.gz && rm  bzip2-$vers.tar.gz && cd bzip2-$vers
#make -f Makefile-libbz2_so
#make clean && make && make -n install PREFIX=$PREFIX
#make install PREFIX=$PREFIX

#------------------------------------------------------------------
#########################
# xz
#########################
echo "xz-5.2.3 breaks yum"
echo -e "$s00 xz $s1"
vers=5.2.3 breaks yum
cd ~
wget "http://tukaani.org/xz/xz-$vers.tar.gz"
tar xzvf xz-$vers.tar.gz && rm xz-$vers.tar.gz
cd ~/xz-$vers
./configure --prefix=$PREFIX 
make
$SUDO make install

#lib/liblzma.so.5: version `XZ_5.1.2alpha' not found (required by /usr/lib64/librpmio.so.3

#------------------------------------------------------------------
#########################
# pcre
#########################
# pcre-8.40 available, I am trying the newer pcre2

echo -e "$s00 pcre $s1"
vers=10.23
cd ~
wget "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre2-$vers.tar.gz"
tar xzvf pcre2-$vers.tar.gz && rm pcre2-$vers.tar.gz
cd ~/pcre2-$vers
./configure \
	--prefix=$PREFIX \
	--enable-utf8 \
	--enable-utf \
	--enable-unicode-properties \
	--enable-jit
make
$SUDO make install
#git clone https://git.tukaani.org/xz.git

