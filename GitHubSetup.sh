#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"


#########################
# github
#########################

#https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet

sudo yum install -y \
    dh-autoreconf \
    expat-devel \
    gettext-devel \
    perl-devel \
    zlib-devel \
    curl-devel

sudo yum install -y \
    asciidoc \
    xmlto \
    gnu-getopt \
    docbook2X 


sudo ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi


## requires UtilsSetup.sh with CURL with ssl support

cd $HOME
vers=2.13.1
wget https://www.kernel.org/pub/software/scm/git/git-$vers.tar.xz
tar -xf git-$vers.tar.xz
rm  git-$vers.tar.xz
cd git-$vers
make configure
./configure --prefix=$HOME
sudo make all info doc
sudo make install  install-html install-info install-doc


  git config --global user.email "jordan.m.adamson@gmail.com"
  git config --global user.name "Jadamso"



## Update git
git clone git://git.kernel.org/pub/scm/git/git.git
