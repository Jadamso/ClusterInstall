#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"
source "EnvironmentSetup.sh"

#------------------------------------------------------------------
#########################
# Stack
#########################

wget -qO- https://get.haskellstack.org/ | sh

#------------------------------------------------------------------
#########################
# Pandoc
#########################

sudo yum install -y ghc

cd ~
vers=1.19.2.1
wget https://hackage.haskell.org/package/pandoc-$vers/pandoc-$vers.tar.gz
tar -xzf pandoc-1.19.2.1.tar.gz && rm pandoc-1.19.2.1.tar.gz
cd pandoc-1.19.2.1

stack setup
stack install --test

#------------------------------------------------------------------
#########################
# GhostScript
#########################
# https://ghostscript.com/doc/9.18/Make.htm
cd $HOME && git clone git://git.ghostscript.com/ghostpdl.git 
cd $HOME/ghostpdl
./autogen.sh --prefix=$HOME
./configure --prefix=$HOME
make
sudo make install 
#https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs920/ghostpdl-9.20.tar.gz

#------------------------------------------------------------------
#########################
# Latex
#########################

sudo yum install -y \
	perl-Digest-MD5.x86_64 \
	ibus-qt-devel.x86_64 \
	poppler-qt-devel.x86_64

#export TEXDIR=$HOME

# TEXLIVE ## https://www.tug.org/texlive/quickinstall.html
cd ~ && wget "http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"
tar -xf "install-tl-unx.tar.gz" && rm "install-tl-unx.tar.gz" && cd ~/install-tl-$(date +%Y%m**)
sudo ./install-tl


