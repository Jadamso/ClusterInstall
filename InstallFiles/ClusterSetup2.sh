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
# Compression
#########################
echo -e "$s0 R Prerequisites... $s1"
bash $IDIR/CompressSetup.sh


#########################
# Math
#########################
echo -e "$s0 Math Prerequisites... $s1"
bash $IDIR/MathSetup.sh


#########################
# Java
#########################
echo -e "$s0 Java Prerequisites... $s1"
bash $IDIR/OpenJavaDevKitSetup.sh


#########################
# MPI
#########################
echo -e "$s0 MPI Prerequisites... $s1"
bash $IDIR/MPISetup.sh



exit
