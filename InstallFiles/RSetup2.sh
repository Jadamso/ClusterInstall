#!/bin/bash
# PREFIX=$HOME
# bash ~/Install/ClusterInstall/RSetup.sh

shopt -s expand_aliases
source "$HOME/.bashrc"
source "EnvironmentSetup.sh"

#------------------------------------------------------------------
#########################
# Enviroment Setup 
#########################
## For Cluster 
if [[ $HOME == "/home/jadamso" ]]
then
    export JAVA_HOME=~/jdk1.8.0_131
    XSET="--without-x"
    #module rm intel/17.0
    #module add gcc/7.1.0

## For Personal
elif [[ $HOME == "/home/Jadamso" ]]
then
	export JAVA_HOME=~/jdk1.8.0_131
else ## [[ $HOME == "ec2-user" ]]
    echo "Shiny must have X capabilites"
    #XSET="--without-x"
fi


#------------------------------------------------------------------
#########################
# R Download Latest
#########################

cd ~
wget https://cran.r-project.org/src/base/R-latest.tar.gz
Rvers=$(tar -tzvf R-latest.tar.gz | head -1 | awk '{print $NF}')
tar -xzf R-latest.tar.gz && rm "R-latest.tar.gz"
cd $Rvers

#------------------------------------------------------------------
#########################
# R Install Flags
#########################
#export PATH=$PREFIX/bin:$PATH
#export LDFLAGS="-L$PREFIX/lib"
#export LD_LIBRARY_PATH=$PREFIX/lib:$LD_LIBRARY_PATH
#export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig 

#http://126kr.com/article/phm94bo1m
#https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Shared-BLAS

#    export CC=gcc #'icc -DMKL_ILP64 '
#    export CXX=gcc
#export FC=gfortran  
#export F77=gfortran 

#PREFIX=$HOME

./configure \
    --prefix=$PREFIX \
    --with-cairo \
    --with-jpeglib \
    --with-libpng \
    --with-libtiff \
    --enable-R-profiling \
    --enable-memory-profiling \
    --with-lapack \
    --with-blas \
    --enable-byte-compiled-packages \
    $XSET



    #--without-recommended-packages
    #--enable-R-shlib
    #--enable-BLAS-shlib 
#------------------------------------------------------------------
#########################
# R Install
#########################

make

$SUDO make install 

$SUDO make install-info

#$SUDO make install-pdf

exit
#------------------------------------------------------------------
#########################
# RMPI
#########################

## module add mpich2/1.4
#rmpi_vers=0.6-6
#cd ~ && wget https://cran.r-project.org/src/contrib/Rmpi_$rmpi_vers.tar.gz
#R CMD INSTALL Rmpi_$rmpi_vers.tar.gz --configure-args=--with-mpi=/opt/mpich2/1.4 --configure-args=--prefix=$HOME

#install.packages("https://cran.r-project.org/src/contrib/installr_0.17.8.tar.gz") 

