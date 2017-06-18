#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"


echo "currently uses git and yum"

# FORTRAN, C, BLAS, LAPACK
sudo yum -y install gmp gmp-devel mpfr mpfr-devel libmpc libmpc-devel
sudo yum -y install cpp gcc gcc-c++ gcc-gfortran gcc-objc.x86_64
sudo yum -y install blas-devel.x86_64 blas64.x86_64 openblas.x86_64 lapack.x86_64 lapack-devel

#########################
# Parallel Programs
#########################

## OpenBLAS
cd ~
vers=0.2.14
wget http://github.com/xianyi/OpenBLAS/archive/v$vers.tar.gz
tar -xzf v$vers.tar.gz && rm v$vers.tar.gz 
#git clone https://github.com/xianyi/OpenBLAS.git
cd ~/OpenBLAS-$vers
make PREFIX=$HOME FC=gfortran TARGET=HASWELL
sudo make PREFIX=$HOME install

## Atlas
cd ~ 
vers=3.10.3
wget https://sourceforge.net/projects/math-atlas/files/Stable/$vers/atlas$vers.tar.bz2
tar -xvjf atlas$vers.tar.bz2 && rm atlas$vers.tar.bz2
cd ~/ATLAS
mkdir build
cd  ~/ATLAS/build
../configure --prefix=$HOME
make 
sudo make install
#git clone https://github.com/math-atlas/math-atlas.git
#cd ~/math-atlas
#mkdir build 
#../configure --prefix=$HOME --shared
#make -j4 srcdir="build"
#cd ~/math-atlas/build
#make -j4


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

## MPI
## HWLOC: yum -y install hwloc.x86_64 
cd ~
#git clone https://github.com/open-mpi/hwloc.git
#cd ~/hwloc
vers=1.11
versa=$vers.7
wget https://www.open-mpi.org/software/hwloc/v$vers/downloads/hwloc-$versa.tar.gz
tar -xzf hwloc-$versa.tar.gz && rm hwloc-$versa.tar.gz
cd ~/hwloc-$versa
./autogen.sh
./configure --prefix=$HOME
make
sudo make install



exit
#########################
# Math Optimization # UNUSED
#########################
## http://www.hiplar.org/hiplar-M-installation.html


# OpenMP: message passing for parallel processing
##  http://courses.cs.washington.edu/courses/csep524/13wi/mpi/mpi_setup.txt
yum install mpich mpich-devel mpich-autoload mpich-autoload
#wget http://www.mpich.org/static/tarballs/3.0.2/mpich-3.0.2.tar.gz
#tar xzf mpich-3.0.2.tar.gz
#rm xzf mpich-3.0.2.tar.gz
#cd mpich-3.0.2
#./configure --prefix=$HOME/mpich-install 2>&1 | tee c.txt
#make 2>&1 | tee m.txt
#make -j4 install 2>&1 | tee mi.txt
# vim ~/.bashrc,  export PATH=$PATH:~/mpich-install/bin
#source ~/.bashrc

#PLASMA
cd && wget http://icl.eecs.utk.edu/projectsfiles/plasma/pubs/plasma-installer_2.8.0.tar.gz
tar -xf "plasma-installer_2.8.0.tar.gz" && rm "plasma-installer_2.8.0.tar.gz" && cd ~/plasma-installer_2.8.0
export OPENBLAS_NUM_THREADS=1
sudo ./setup.py --prefix="$HOME" --blaslib="-L$HOME/lib -lopenblas" --cflags="-O3 -fPIC -I$HOME/include" --fflags="-O3 -fPIC" --noopt="-fPIC" --notesting --ldflags_c="-I$HOME/include" --downlapc --nbcores=3
cd $HOME/lib # Make shared libraries # 
sudo gcc -shared -o libplasma.so -Wl,-whole-archive libplasma.a -Wl,-no-whole-archive -L. -lhwloc 
sudo gcc -shared -o libcoreblas.so -Wl,-whole-archive libcoreblas.a -Wl,-no-whole-archive 
sudo gcc -shared -o libquark.so -Wl,-whole-archive libquark.a -Wl,-no-whole-archive

##cd ~ && wget http://www.hiplar.org/downloads/HiPLARM.Installer
##./HiPALRM.Installer --prefix=$HOME/lib --with-openblas --no-gpu

## CUDA: gpu processing
cd ~ && wget http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-7.5-18.x86_64.rpm
sudo rpm -i cuda-repo-rhel7-7.5-18.x86_64.rpm
sudo yum clean all
sudo yum install cuda
   export LD_LIBRARY_PATH=/usr/local/cuda/lib
   export PATH=$PATH:/usr/local/cuda/bin

## MAGMA: cpu and gpu computing
Mvers=2.0.1
cd ~ && wget http://icl.cs.utk.edu/projectsfiles/magma/downloads/magma-$Mvers.tar.gz
tar -xf magma-$Mvers.tar.gz && rm magma-$Mvers.tar.gz && cd ~/magma-$Mvers
cd ~/magma-$Mvers/src && wget http://www.hiplar.org/files/MAGMApatch.sh
sudo bash ./MAGMApatch.sh ## http://www.hiplar.org/downloads/magmapatch.tar.gz
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

