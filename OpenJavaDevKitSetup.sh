#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"

exit 

#########################
# Open Java Dev. Kit
#########################
# Download Manually to PC after clicking `'agree'`
# Then Upload to CLuster
# THen install on Cluster


jvers='jdk-8u131'
#scp  ~/Desktop/$jvers.tar.gz jadamso@user.palmetto.clemson.edu:/home/jadamso
Upload -u Cluster $jvers-linux-x64.tar.gz 


#http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

## cd ~
# wget http://download.oracle.com/otn-pub/java/jdk/8u65-b17/$jvers.tar.gz
## manually download from http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html


tar -zxvf $jvers-linux.tar.gz && rm $jvers-linux.tar.gz
cd ~/jdk1.8.0_131
unzip src.zip

#-Djava.library.path="${workspace_loc:project}\lib;${env_var:PATH}"
#export JAVA_CPPFLAGS=-I~/jdk1.8.0_65/include

echo "export JAVA_HOME=~/jdk1.8.0_131"

