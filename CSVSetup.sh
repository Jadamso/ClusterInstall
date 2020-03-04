#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"
source "EnvironmentSetup.sh"

#------------------------------------------------------------------
#########################
# File Conversion
#########################
# .xls .xlsx .csv 
#https://stackoverflow.com/questions/10557360/convert-xlsx-to-csv-in-linux-command-line/25626555

#------------------------------------------------------------------
#########################
# XLS2CSV
#########################

## see also http://stackoverflow.com/questions/10557360/convert-xlsx-to-csv-in-linux-command-line
vers=0.95 #0.94.2
cd ~ && wget http://ftp.wagner.pp.ru/pub/catdoc/catdoc-$vers.tar.gz
tar -xf catdoc-$vers.tar.gz && rm catdoc-$vers.tar.gz 
cd ~/catdoc-$vers
./configure --prefix=$PREFIX
mkdir ~/share/catdoc
make
sudo make install

#------------------------------------------------------------------
#########################
# CSVKIT
#########################

cd ~
git clone https://github.com/wireservice/csvkit.git
#wget https://github.com/onyxfish/csvkit/archive/master.zip
#unzip master.zip && rm master.zip
cd ~/csvkit
$SUDO python setup.py install --prefix=$PREFIX


sudo pip install csvkit

#in2csv data.xlsx > data.csv



#------------------------------------------------------------------
#########################
# Other
#########################

#easy_install xlsx2csv
#xlsx2csv file.xlsx > newfile.csv


## Pandoc
#yum -y install ghc-pandoc.x86_64

## Libre Office
#vers=4.4.5.2 #5.0.1.2
#cd ~ && wget http://download.documentfoundation.org/libreoffice/src/4.4.5/libreoffice-$vers.tar.xz
#tar -xzf libreoffice-$vers.tar.xz && rm libreoffice-$vers.tar.xz && cd libreoffice-$vers
#./configure --prefix=$HOME --disable-cups --disable-gconf --disable-dbus --disable-gstreamer-1.0 --without-doxygen 
