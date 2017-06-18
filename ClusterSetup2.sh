#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"

# Installation Instructions to Download and Install Source Programs 
# Jordan Adamson, Sep22, 2016
# 		, Jan29, 2017

s0="\e[1;92m"
s00="\e[92m"
s1="\e[0m\n"

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
# Compression
#########################
echo -e "$s0 R Prerequisites... $s1"
bash $IDIR/CompressSetup.sh


#########################
# R
#########################
echo -e "$s0 R ... $s1" #with MKLR
bash $IDIR/RSetup.sh

## Temporary fix on Cluster
#module add anaconda3/2.5.0
#/software/anaconda3/2.5.0/envs/R/bin/R







exit
