#!/bin/bash
# PREFIX=$HOME
# bash ~/Install/ClusterInstall/RSetup.sh

shopt -s expand_aliases
source "$HOME/.bashrc"

module rm intel/17.0
module add gcc/7.1.0


#########################
# Sudo Setup 
#########################

## For Cluster 
if [[ $HOME == "/home/jadamso" ]] ; then
	SUDO=""
## For Personal
elif [[ $HOME == "/home/Jadamso" ]] ; then
	SUDO=sudo
fi


#########################
# R Install
#########################

## Latest
cd ~
wget https://cran.r-project.org/src/base/R-latest.tar.gz
Rvers=$(tar -tzvf R-latest.tar.gz | head -1 | awk '{print $NF}')
tar -xzf R-latest.tar.gz && rm "R-latest.tar.gz"
cd $Rvers


#########################
# R Install Flags
#########################
## Configure 

#PREFIX=$HOME


## Setup Install
export PATH=$PREFIX/bin:$PATH


export LDFLAGS="-L$PREFIX/lib"
export LD_LIBRARY_PATH=$PREFIX/lib:$LD_LIBRARY_PATH

export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig 

#http://126kr.com/article/phm94bo1m
#https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Shared-BLAS

    export CC=gcc #'icc -DMKL_ILP64 '
    export CXX=gcc
export FC=gfortran  
export F77=gfortran 

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
    --enable-byte-compiled-packages


    #--without-recommended-packages
    #--enable-R-shlib
    #--enable-BLAS-shlib 

#########################
# R 
#########################

## Install
make
$SUDO make install 

## Rprofile
cp ~/Rprofile.site ~/lib64/R/etc/Rprofile.site ## Cluster without revolution
#chmod -R a+w ~/lib64/R/library

unset CFLAGS


## Update Packages
# ~/Desktop/Common/R_Code/LIBS.R 

exit



## Can Optimize a personal code -- i.e. pow_wrp.c
#if [[ "$HOME " == "\home\jadamso" ]]  
#then
#    ipath=/software/intel/compilers_and_libraries_2016.2.181/linux/bin/intel64
#    export LD_LIBRARY_PATH=$ipath/:./lib:./:$LD_LIBRARY_PATH
#    icc -O2 -fPIC -I/R-$Rvers/include -c pow_wrp.c -o pow_wrp.o
#    icc -shared -liomp5 -L$ipath-lmkl_rt -o pow_wrp.so pow_wrp.o -L./lib -lR
#fi


exit

#########################
# RMPI
#########################

## module add mpich2/1.4
rmpi_vers=0.6-6
cd ~ && wget https://cran.r-project.org/src/contrib/Rmpi_$rmpi_vers.tar.gz
R CMD INSTALL Rmpi_$rmpi_vers.tar.gz --configure-args=--with-mpi=/opt/mpich2/1.4 --configure-args=--prefix=$HOME


#install.packages("https://cran.r-project.org/src/contrib/installr_0.17.8.tar.gz") 



