#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"


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
# GeoSpatial Programs
#########################
# Pre-requisites to use R as a GIS
## old but works: Proj4 vers=4.7.0, GDAL vers=2.0.2 

echo "https://github.com/OSGeo"
echo "http://elgis.argeo.org/"
## NetCDF: https://www.unidata.ucar.edu/software/netcdf/docs/build_parallel.html
echo -e "$s00 NetCDF $s1"
vers=4.4.1
cd ~ && wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-$vers.tar.gz
tar -xzf netcdf-$vers.tar.gz && rm netcdf-$vers.tar.gz && cd netcdf-$vers
./configure \
	--prefix=$PREFIX \
	--enable-parallel \
	--enable-remote-fortran-bootstrap
make
$SUDO make install

## GEOS:
echo -e "$s00 GEOS $s1"
vers=3.6.1
cd ~ &&  wget http://download.osgeo.org/geos/geos-$vers.tar.bz2
tar -xjf geos-$vers.tar.bz2 && rm geos-$vers.tar.bz2 && cd ~/geos-$vers
./configure \
	--prefix=$PREFIX \
	--enable-python
make
$SUDO make install

## Proj4: http://stackoverflow.com/questions/33381421/how-to-upgrade-proj4-for-rgdal
echo -e "$s00 Proj4 $s1"
vers=4.9.3
dvers=1.6
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


echo -e "$s00 GDAL $s1"
cd ~
vers=2.2.0
wget "http://download.osgeo.org/gdal/$vers/gdal-$vers.tar.gz"
tar -xzf gdal-$vers.tar.gz && rm gdal-$vers.tar.gz
cd ~/gdal-$vers
unset CFLAGS
./configure \
	--prefix=$PREFIX \
	--with-pic \
	--with-threads \
	--with-poppler \
	--with-pg \
	--with-curl \
	--with-openjpeg \
	--with-geos \
	--with-geotiff \
	--with-jpeg \
	--with-png \
	--with-expat \
	--with-jav \
	--with-netcdf \
	CC=icc \
	F77=ifort \
	FC=ifort
# GDAL:

## on PC add --without-libtool --with-opencl --with-python and remove --prefix=$PREFIX
make
$SUDO make install

gdal-config --version
ogr2ogr --version
gdal-config --cflags


