#!/bin/bash
# PREFIX=$HOME
# bash ~/Install/ClusterInstall/RSetup.sh

shopt -s expand_aliases
source "$HOME/.bashrc"

#module rm intel/17.0
#module add gcc/7.1.0


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

export CFLAGS="-I$PREFIX/include:$PREFIX"
export C_INCLUDE_PATH=$PREFIX/include
export CPLUS_INCLUDE_PATH=$PREFIX/include

export LDFLAGS="-L$PREFIX/lib"
export LD_LIBRARY_PATH=$PREFIX/lib:$LD_LIBRARY_PATH

export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig 

export PKG_CXXFLAGS="-I$PREFIX/include:$PREFIX" #-DARMA_64BIT_WORD 

#export _JAVA_OPTIONS=-Xms and -Xmx 

if [[ "$HOME" == "/home/jadamso" ]]  
## On Palmetto Cluster
then

    export AR="xiar"
    export LD="xild"

   #export MKL="-lmkl_gf_lp64 -lmkl_intel_thread -lmkl_core -liomp5 -lpthread "
    #--with-blas=-lmkl
   export MKL="-lmkl_gf_lp64 -lmkl_intel_thread -lmkl_core -liomp5 -lpthread "

    export FC=ifort  #'ifort -i8'
    export F77=ifort 
    #FC=" ifort -mkl -I/tmp/readline/include -L/tmp/readline/lib"\
    #F77=" ifort -mkl -I/tmp/readline/include -L/tmp/readline/lib"\

    export LANGUAGE=C
    export LC_MESSAGES=C
    export LC_ALL=C

    export CC=icc #'icc -DMKL_ILP64 '
    export CXX=icpc
    #export CFLAGS="-O3 -ipo -openmp -xHost"
    #export CXXFLAGS="-O3 -ipo -openmp -xHost"

    export CPICFLAGS=" -fPIC"
    export FPICFLAGS=" -fPIC"


    #export PalmClust='--with-blas $MKL --with-x=no CC=icc FC=ifort F77=ifort'
    export PalmClust=' \
        CC=" icc -mkl -I/tmp/readline/include -L/tmp/readline/lib" \
        CXX=" icpc -I/tmp/readline/include -mkl -L/tmp/readline/lib" \
        FC=" ifort -mkl -I/tmp/readline/include -L/tmp/readline/lib" \
        F77=" ifort -mkl -I/tmp/readline/include -L/tmp/readline/lib" \
        FPICFLAGS=" -fPIC" AR=xiar LD=xild --with-x=no --with-blas=-lmkl'

else 

    if [[ "$INTEL " == "TRUE" ]]
    then
        echo -e "Notes for Intel:"
        echo -e "    https://software.intel.com/en-us/articles/build-r-301-with-intel-c-compiler-and-intel-mkl-on-linux"
        echo -e "    https://software.intel.com/en-us/node/528682"
        ## On PC
        echo -e 'exclude "--with-blas $MKL --with-x=no CC=icc FC=ifort F77=ifort"'
    else
        echo "Proceeding to configure"
    fi
fi


#http://126kr.com/article/phm94bo1m
#https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Shared-BLAS

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
    $PalmClust 


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



