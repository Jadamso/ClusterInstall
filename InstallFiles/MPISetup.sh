#!/bin/bash
shopt -s expand_aliases
source "$HOME/.bashrc"
source "EnvironmentSetup.sh"

#------------------------------------------------------------------
#########################
# HWLOC
#########################

cd ~
#git clone https://github.com/open-mpi/hwloc.git
#cd ~/hwloc
vers=1.11
versa=$vers.7
cd ~
wget https://www.open-mpi.org/software/hwloc/v$vers/downloads/hwloc-$versa.tar.gz
tar -xzf hwloc-$versa.tar.gz && rm hwloc-$versa.tar.gz
cd ~/hwloc-$versa
./autogen.sh
./configure --prefix=$HOME
make
$SUDO make install


exit


#------------------------------------------------------------------
#########################
# OpenMPI
#########################


vers=2.1
versa=$vers.1
cd ~
wget https://www.open-mpi.org/software/ompi/v$vers/downloads/openmpi-$versa.tar.gz
tar xzf openmpi-$versa.tar.gz && rm openmpi-$versa.tar.gz
cd openmpi-$versa
./configure --prefix=$HOME
make
$SUDO make install


exit
# OpenMP: message passing for parallel processing
##  http://courses.cs.washington.edu/courses/csep524/13wi/mpi/mpi_setup.txt



#------------------------------------------------------------------
#########################
# MPICH
#########################



vers=3.2
cd ~
wget http://www.mpich.org/static/downloads/$vers/mpich-$vers.tar.gz
tar xzf mpich-$vers.tar.gz && rm mpich-$vers.tar.gz
cd mpich-$vers


#./configure --prefix=$HOME/mpich-install 2>&1 | tee c.txt
#make 2>&1 | tee m.txt
#make -j4 install 2>&1 | tee mi.txt
# vim ~/.bashrc,  export PATH=$PATH:~/mpich-install/bin
#source ~/.bashrc

