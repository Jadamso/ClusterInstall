#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"
source "EnvironmentSetup.sh"

# Installation Instructions to Download and Install Source Programs 
# Jordan Adamson, Sep22, 2016
# 		, Jan29, 2017

#------------------------------------------------------------------
#########################
# Linux Environment
#########################
echo -e "$s0 Linux Environment... $s1"

#echo "module add intel/15.0" >> ~/.bashrc
#echo 'export MAKEFLAGS="-j $(grep -c ^processor /proc/cpuinfo)"' >> ~/.bashrc

## use all cores when building programs
export MAKEFLAGS="-j $(grep -c ^processor /proc/cpuinfo)"

#------------------------------------------------------------------
#########################
# Bash, RCurl
#########################
echo -e "$s0 Bash, Wget ... $s1"
bash $IDIR/UtilsSetup.sh
#------------------------------------------------------------------
#########################
# openSSH
#########################
echo -e "$s0 openSSH ... $s1"
bash $IDIR/SSHSetup.sh

#------------------------------------------------------------------#########################
# Rsync, Rclone
#########################
echo -e "$s0 Rsync, Rclone ... $s1"
bash $IDIR/SyncSetup.sh

#------------------------------------------------------------------
#########################
# Terminal Multiplexer
#########################
echo -e "$s0 Tmux... $s1"
bash $IDIR/TMUXSetup.sh

