#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"
source "EnvironmentSetup.sh"

#https://stackoverflow.com/questions/5260068/multithreaded-blas-in-python-numpy/7645939#7645939
#http://blog.nguyenvq.com/blog/2014/11/10/optimized-r-and-python-standard-blas-vs-atlas-vs-openblas-vs-mkl/


#------------------------------------------------------------------
#########################
# Lapack
#########################

#https://github.com/Reference-LAPACK/lapack-release


#------------------------------------------------------------------
#########################
# OpenBLAS
#########################

cd ~
vers=0.2.20
wget https://github.com/xianyi/OpenBLAS/archive/v$vers.tar.gz
tar -xzf v$vers.tar.gz && rm v$vers.tar.gz 
#git clone https://github.com/xianyi/OpenBLAS.git

cd ~/OpenBLAS-$vers
make PREFIX=$HOME FC=gfortran #TARGET=HASWELL
$SUDO make PREFIX=$HOME install

exit



#------------------------------------------------------------------
#########################
# Atlas
#########################

cd ~ 
vers="3.11.38" #3.10.3
wget https://github.com/math-atlas/math-atlas/archive/v$vers.tar.gz

#https://sourceforge.net/projects/math-atlas/files/Stable/$vers/atlas$vers.tar.bz2
tar -xzf v$vers.tar.gz && rm v$vers.tar.gz
cd ~/math-atlas-$vers
make srcdir=build
cd  ~/math-atlas-$vers/build
make 
$SUDO make install

#git clone https://github.com/math-atlas/math-atlas.git
#cd ~/math-atlas
#mkdir build 
#../configure --prefix=$HOME --shared
#make -j4 srcdir="build"
#cd ~/math-atlas/build
#make -j4

#------------------------------------------------------------------
#########################
# Armadillo
#########################


cd ~
vers=7.950.1
wget http://sourceforge.net/projects/arma/files/armadillo-$vers.tar.xz
tar xf armadillo-$vers.tar.xz && rm armadillo-$vers.tar.xz
cd armadillo-$vers

#./configure=$HOME
cmake .
make
$SUDO make install DESTDIR=$HOME/
#mv lib64/* ../lib64
#mv include/* ../include
#mv share/* ../share


## http://bitbucket.org/eigen/eigen/get/3.3.4.tar.bz2


## GotoBLAS2
#cd ~ && wget https://www.tacc.utexas.edu/documents/1084364/1087496/GotoBLAS2-1.13.tar.gz
#tar -xzf GotoBLAS2-1.13.tar.gz && rm GotoBLAS2-1.13.tar.gz && cd GotoBLAS2
#make BINARY=64 USE_THREAD=1 INTERFACE64=1 make PREFIX=$HOME FC=gfortran TARGET=NEHALEM

## After Installing Packages:  sudo ldconfig -v
## On Palmetto Cluster must configure using --prefix=$HOME

## NetCDF-Fortran: OPTIONAL
#cd ~ && wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.4.2.tar.gz
#tar -xzf netcdf-fortran-4.4.2.tar.gz && rm netcdf-fortran-4.4.2.tar.gz && cd netcdf-fortran-4.4.2
#./configure --prefix=$HOME --enable-parallel

exit
#########################
# Math Optimization # UNUSED
#########################
## http://www.hiplar.org/hiplar-M-installation.html


#PLASMA
cd && wget http://icl.eecs.utk.edu/projectsfiles/plasma/pubs/plasma-installer_2.8.0.tar.gz
tar -xf "plasma-installer_2.8.0.tar.gz" && rm "plasma-installer_2.8.0.tar.gz" && cd ~/plasma-installer_2.8.0
export OPENBLAS_NUM_THREADS=1
$SUDO ./setup.py --prefix="$HOME" --blaslib="-L$HOME/lib -lopenblas" --cflags="-O3 -fPIC -I$HOME/include" --fflags="-O3 -fPIC" --noopt="-fPIC" --notesting --ldflags_c="-I$HOME/include" --downlapc --nbcores=3
cd $HOME/lib # Make shared libraries # 
$SUDO gcc -shared -o libplasma.so -Wl,-whole-archive libplasma.a -Wl,-no-whole-archive -L. -lhwloc 
$SUDO gcc -shared -o libcoreblas.so -Wl,-whole-archive libcoreblas.a -Wl,-no-whole-archive 
$SUDO gcc -shared -o libquark.so -Wl,-whole-archive libquark.a -Wl,-no-whole-archive

##cd ~ && wget http://www.hiplar.org/downloads/HiPLARM.Installer
##./HiPALRM.Installer --prefix=$HOME/lib --with-openblas --no-gpu

## CUDA: gpu processing
cd ~ && wget http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-7.5-18.x86_64.rpm
$SUDO rpm -i cuda-repo-rhel7-7.5-18.x86_64.rpm
$SUDO yum clean all
$SUDO yum install cuda
   export LD_LIBRARY_PATH=/usr/local/cuda/lib
   export PATH=$PATH:/usr/local/cuda/bin

## MAGMA: cpu and gpu computing
Mvers=2.0.1
cd ~ && wget http://icl.cs.utk.edu/projectsfiles/magma/downloads/magma-$Mvers.tar.gz
tar -xf magma-$Mvers.tar.gz && rm magma-$Mvers.tar.gz && cd ~/magma-$Mvers
cd ~/magma-$Mvers/src && wget http://www.hiplar.org/files/MAGMApatch.sh
$SUDO bash ./MAGMApatch.sh ## http://www.hiplar.org/downloads/magmapatch.tar.gz
cd ~/magma-$Mvers && cp make.inc.goto make.inc
gedit make.inc
 OPTS = -O3 -DADD_ -fPIC
 F77OPTS = -O3 -DADD_ -fPIC
 FOPTS = -O3 -DADD_ -x f95-cpp-input -fPIC 
 NVOPTS = -O3 -DADD_  --compiler-options -fPIC,-fno-strict-aliasing -DUNIX 
 LDOPTS = -fPIC -Xlinker -zmuldefs
 CUDADIR  = /usr/local/cuda #CUDADIR = $CUDADIR 
 LIB = -lopenblas -lpthread -lcublas -lm 
 LIBDIR = -L$HOME/lib -L$CUDADIR/lib64 -L/usr/lib64 
 INC = -I$CUDADIR/include
cd $HOME/magma-2.0.1/lib && gcc -shared -o libmagma.so -Wl,-whole-archive libmagma.a -Wl,-no-whole-archive
make shared
make test
make -j4 install prefix=/usr/local/magma


## Lapack C Wrapper
#http://www.netlib.org/lapack/lapwrapc/

