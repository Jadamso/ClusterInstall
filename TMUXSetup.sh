#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"


#########################
# Terminal Multiplexer
#########################

PREFIX=$HOME

## LIBEVENT
vers=2.1.8 #2.0.22
cd ~
wget "https://github.com/libevent/libevent/releases/download/release-$vers-stable/libevent-$vers-stable.tar.gz"
# "https://sourceforge.net/projects/levent/files/libevent/libevent-2.0/libevent-2.0.22-stable.tar.gz"
tar -xzf libevent-$vers-stable.tar.gz && rm libevent-$vers-stable.tar.gz && cd ~/libevent-$vers-stable
./configure --prefix=$PREFIX --disable-static # --disable-shared
make
sudo make install

## ncurses
vers=6.0 #5.9
cd ~
wget "ftp://ftp.gnu.org/gnu/ncurses/ncurses-$vers.tar.gz"
tar xvzf ncurses-$vers.tar.gz && rm ncurses-$vers.tar.gz
cd ~/ncurses-$vers
./configure --prefix=$PREFIX
make
sudo make install

# sudo yum install -y cmake.x86_64
# TMUX
vers=2.5 #2.0 
cd ~
wget "https://github.com/tmux/tmux/releases/download/$vers/tmux-$vers.tar.gz"
tar -xzf tmux-$vers.tar.gz && rm "tmux-$vers.tar.gz"
cd ~/tmux-$vers
./configure  --prefix=$PREFIX \
	CFLAGS="-I$PREFIX/include -I$PREFIX/include/ncurses"\
	LDFLAGS="-static -L$PREFIX/lib -L$PREFIX/include/ncurses -L$PREFIX/include"\
	CPPFLAGS="-I$PREFIX/include -I$PREFIX/include/ncurses"
make
sudo cp tmux $PREFIX/bin



## Tmux Status
cd ~ && wget https://github.com/thewtex/tmux-mem-cpu-load/archive/master.zip
unzip master.zip && rm master.zip && cd ~/tmux-mem-cpu-load-master
cmake .
make



