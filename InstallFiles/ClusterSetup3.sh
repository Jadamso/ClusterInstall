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



#########################
# GeoSpatial Programs
#########################
echo -e "$s0 GeoSpatial Programs... $s1"
bash $IDIR/OSGEOSetup.sh



#########################
# R
#########################
echo -e "$s0 R ... $s1" #with MKLR
bash $IDIR/RSetup2.sh
bash $IDIR/RPostInstallSetup.sh

