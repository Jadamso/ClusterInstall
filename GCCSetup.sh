#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"


#########################
# GCC Install
#########################


## GMP
vers=6.1.2
cd ~
wget https://gmplib.org/download/gmp/gmp-$vers.tar.xz
tar -xf gmp-$vers.tar.xz && rm gmp-$vers.tar.xz
cd ~/gmp-$vers
./configure --prefix=$HOME
make
sudo make install 


## MPFR
vers=3.1.5
cd ~
wget http://www.mpfr.org/mpfr-current/mpfr-$vers.tar.xz
tar -xf mpfr-$vers.tar.xz && rm mpfr-$vers.tar.xz
cd ~/mpfr-$vers
./configure --prefix=$HOME
make 
sudo make install


## MPC
vers=1.0.3
cd ~
wget https://ftp.gnu.org/gnu/mpc/mpc-$vers.tar.gz
tar -xzf mpc-$vers.tar.gz && rm mpc-$vers.tar.gz
cd ~/mpc-$vers
./configure --prefix=$HOME
make
sudo make install

## GCC prereq
sudo yum install -y \
	zlib-devel.x86_64 \
	gcc-go.x86_64

## GCC
vers=7.1.0

PATH=/usr/bin:$PATH
cd ~
wget http://mirrors-usa.go-parts.com/gcc/releases/gcc-$vers/gcc-$vers.tar.gz
tar -xf gcc-$vers.tar.gz && rm gcc-$vers.tar.gz
cd ~/gcc-$vers
./configure \
	--prefix=$HOME \
    --disable-multilib \
    --with-system-zlib \
    --enable-languages=c,c++,fortran,go,objc,obj-c++
make
sudo make install

source $HOME/.bashrc

exit


# Intel OpenCL RunTime
cd ~ && wget "http://registrationcenter.intel.com/irc_nas/5193/opencl_runtime_15.1_x64_5.0.0.57.tgz"
tar -xvf "opencl_runtime_15.1_x64_5.0.0.57.tgz" && rm "opencl_runtime_15.1_x64_5.0.0.57.tgz"
cd ~/opencl_runtime_15.1_x64_5.0.0.57 && sudo ./install.sh

# Intel OpenCL CodeBuilder
cd ~ && wget "http://registrationcenter.intel.com/irc_nas/5193/intel_code_builder_for_opencl_2015_5.0.0.62_x64.tgz"
tar -xvf "intel_code_builder_for_opencl_2015_5.0.0.62_x64.tgz" && rm "intel_code_builder_for_opencl_2015_5.0.0.62_x64.tgz"
cd ~/intel_code_builder_for_opencl_2015_5.0.0.62_x64 && sudo ./install.sh

# INTEL Parallel Suite: serial number: SKCG-4CXD8Z3B
## Manually Download and Unpack to ~/parallel_studio_xe_2015_update3
## Copy over from local to remote: sshpass -p "$PASS" scp $PORT -rp ~/parallel_studio_xe_2016.tgz $DEST:~
tar -xvf "parallel_studio_xe_2016.tgz" && mv parallel_studio_xe_2016.tgz ~/parallel_studio_xe_2016
cd ~/parallel_studio_xe_2016 && sudo ./install.sh


