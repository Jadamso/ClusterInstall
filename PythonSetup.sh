#!/bin/bash

shopt -s expand_aliases
source "$HOME/.bashrc"

#########################
# Python
#########################

yum install -y \
	python-devel \
	numpy.x86_64 \
	python-tools \
	python-docutils.noarch

sudo yum install -y python2* --skip-broken
sudo yum install -y python34*




# http://datascienceatthecommandline.com/#tools
vers=3.6.1
cd ~ && wget https://www.python.org/ftp/python/$vers/Python-$vers.tar.xz
tar -xf Python-$vers.tar.xz && rm Python-$vers.tar.xz
cd ~/Python-$vers
./configure --prefix=$HOME --enable-optimizations
make
sudo make install

#sudo python ./setup.py uninstall

#########################
# EZ install
#########################
cd ~/Python-$vers
wget --no-check-certificate https://bootstrap.pypa.io/ez_setup.py
python ez_setup.py --insecure

#########################
# Pip
#########################

cd ~/Python-$vers
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.pyh
easy_install pip

#rm easy_install-3.6 pip3.6 pip3 python3.6m python3.6 python3.6m-config


exit


#########################
# Update
#########################

## Update All Python Packages
sudo pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo pip install -U

## Update Pip
sudo pip install -U pip



pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo pip install --upgrade --force- -U











## NSPR prereq
cd ~
vers=4.15
wget https://ftp.mozilla.org/pub/mozilla.org/nspr/releases/v$vers/src/nspr-$vers.tar.gz
tar -xvf nspr-$vers.tar.gz && rm nspr-$vers.tar.gz
cd ~/nspr-$vers/nspr
echo "http://www.linuxfromscratch.org/blfs/view/svn/general/nspr.html"
sed -ri 's#^(RELEASE_BINS =).*#\1#' pr/src/misc/Makefile.in &&
sed -i 's#$(LIBRARY) ##'            config/rules.mk         &&

./configure --prefix=$HOME \
            --with-mozilla \
            --with-pthreads \
            $([ $(uname -m) = x86_64 ] && echo --enable-64bit)
make
sudo make install


#### INSTALL RPM ITSELF
vers=4.13
versa=$vers.0.1
cd ~
wget http://ftp.rpm.org/releases/rpm-$vers.x/rpm-$versa.tar.bz2
tar -xvjpf rpm-$versa.tar.bz2 && rm rpm-$versa.tar.bz2
cd ~/rpm-$versa
./configure --prefix=$HOME
make
make install


sudo rpm -i https://www.rpmfind.net/linux/RPM/centos/7.3.1611/x86_64/Packages/xz-libs-5.2.2-1.el7.x86_64.html


## Deleted librpmio.so.3
librpmbuild.so.3.2.2  librpmio.so.3.2.2  librpmsign.so.1.2.2  librpm.so.3.2.2


python setup.py install 
#ftp://rpmfind.net/linux/Mandriva/devel/cooker/x86_64/media/main/release/python-rpm-5.4.10-10-mdv2012.0.x86_64.rpm
#https://ask.fedoraproject.org/en/question/35339/f19-yum-not-working-after-update-solved/

 locate librpm
rm -fv /lib/librpmio.so.3

cp '/lib64/librpmio.so.3.2.2' /lib64/librpmio.so.3
cp '/lib64/librpmbuild.so.3.2.2' /lib64/librpmbuild.so.3
cp '/lib64/librpm.so.3.2.2' /lib64/librpm.so.3
export PATH=$PATH:/usr/lib64

