#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"
source "EnvironmentSetup.sh"

#------------------------------------------------------------------
#########################
# Enviroment Setup 
#########################
## For Cluster 
if [[ $HOME == "/home/jadamso" ]] ; then
    JAVA="--with-java=$JAVA_HOME"
    ARMADILLO="--with-armadillo=$HOME/armadillo-7.950.1"
    STDIO="--with-unix-stdio-64=yes"
fi

#------------------------------------------------------------------
#########################
# GeoSpatial Programs
#########################
# Pre-requisites to use R as a GIS
## old but works: Proj4 vers=4.7.0, GDAL vers=2.0.2 

echo "https://github.com/OSGeo"
echo "http://elgis.argeo.org/"

#------------------------------------------------------------------
#########################
# GEOS
#########################

echo -e "$s00 GEOS $s1"
vers=3.7
cd ~ &&  wget http://download.osgeo.org/geos/geos-$vers.tar.bz2
tar -xjf geos-$vers.tar.bz2 && rm geos-$vers.tar.bz2
cd ~/geos-$vers
./configure \
    --prefix=$PREFIX
    #--enable-python
make
$SUDO make install

#------------------------------------------------------------------
#########################
# Proj4
#########################
# http://stackoverflow.com/questions/33381421/how-to-upgrade-proj4-for-rgdal

echo -e "$s00 Proj4 $s1"
vers=5.2.0 #4.9.3
dvers=1.8 #1.6
cd ~
wget "http://download.osgeo.org/proj/proj-$vers.tar.gz"
tar -xzf "proj-$vers.tar.gz" &&  rm "proj-$vers.tar.gz" 
cd ~/"proj-$vers/nad" && wget "http://download.osgeo.org/proj/proj-datumgrid-$dvers.zip"
unzip "proj-datumgrid-$dvers.zip"
cd ~/"proj-$vers"
./configure \
    --prefix=$PREFIX \
    --enable-shared=yes
make
$SUDO make install

#------------------------------------------------------------------
#########################
# GDAL
#########################

echo -e "$s00 GDAL $s1"
cd ~
vers=2.3.2 #2.2.1
wget "http://download.osgeo.org/gdal/$vers/gdal-$vers.tar.gz"
tar -xzf gdal-$vers.tar.gz && rm gdal-$vers.tar.gz

cd ~/gdal-$vers
./autogen.sh

echo "https://trac.osgeo.org/gdal/wiki/BuildingOnUnixWithMinimizedDrivers"

./configure \
    --prefix=$PREFIX \
    --with-pic \
    --with-threads \
    --with-pg \
    --with-pcre \
    --with-curl \
    --with-openjpeg \
    --with-geos \
    --with-geotiff \
    --with-jpeg \
    --with-png \
    --with-expat \
    --with-hdf5=no \
    $STDIO \
    $ARMADILLO \
    $JAVA
    
#    --with-netcdf \
#    --with-poppler \
#   --with-python \
#    CC=icc \
#    F77=ifort \#
#    FC=ifort


## on PC add --without-libtool --with-opencl --with-python and remove --prefix=$PREFIX
make
$SUDO make install

source $HOME/.bashrc
gdal-config --version
ogr2ogr --version
gdal-config --cflags

exit

#------------------------------------------------------------------
#########################
# HDF5
#########################

#wget https://www.hdfgroup.org/package/bzip2/?wpdmdl=4300 -O HDF5.tar.bzip2
#tar xvfj HDF5.tar.bzip2 && rm HDF5.tar.bzip2
#cd hdf5 

#------------------------------------------------------------------
#########################
# NetCDF
#########################
# https://www.unidata.ucar.edu/software/netcdf/docs/build_parallel.html

echo -e "$s00 NetCDF $s1"
vers=4.6.3
cd ~ && wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-$vers.tar.gz
tar -xzf netcdf-$vers.tar.gz && rm netcdf-$vers.tar.gz 
cd netcdf-$vers
./configure \
    --prefix=$PREFIX \
    --enable-parallel \
    --disable-shared \
    --enable-parallel-tests  \
    --enable-remote-fortran-bootstrap
make
$SUDO make install
