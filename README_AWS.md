# Amazon Setup


<!--http://mgritts.github.io/2016/07/08/shiny-aws/
https://www.r-bloggers.com/rstudio-in-the-cloud-with-amazon-lightsail-and-docker/
https://aws.amazon.com/blogs/big-data/running-r-on-aws/
-->


## On the Amazon website

Create Amazon Lightsail Account
 * choose Amazon Linux for Shiny Server
 * choose Ubuntu for O-Tree Server

Create an instance and a static public IP
 * https://lightsail.aws.amazon.com/ls/webapp/account/profile


Manually open up your firewall to traffic by creating 2 custom networks for TCP
 * port range 3838
 * port range 4151
    


## Setup SSH from local PC
<!-- to delete old
vim ~/.ssh/known_hosts
-->

manually download a private SSH key on AWS

format and install key
```bash
mv ~/Downloads/LightsailDefaultKey.pem \
    ~/.ssh/LightsailDefaultKey.pem
## Format the key 
chmod 600 ~/.ssh/LightsailDefaultKey.pem
## Add EC2 pem key to SSH
ssh-add ~/.ssh/LightsailDefaultKey.pem
```

login!
```bash
## ssh -i LightsailDefaultKey.pem ec2-user@XXX.XXX.XXX.XXX
ssh -i LightsailDefaultKey.pem ubuntu@XXX.XXX.XXX.XXX
```

### Add aditional users
new user generates key-pair
upload to server (manually copy to computer with authorization, then scp to server)
```bash
## scp public ec2-user@XX.XXX.XXX.XX:~/.ssh
scp public ubuntu@XX.XXX.XXX.XX:~/.ssh
```


configure the server
```bash
cat public >> authorized_keys ## add the new key
chmod 755 authorized_keys ## modify authorization
sudo cp authorized_keys /root/.ssh/authorized_keys
sudo service sshd restart ## restart
```

# Common Programs

```bash
sudo sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/epel.repo

sudo yum update -y 
sudo yum install -y git git-daemon.x86_64 gitweb.noarch
sudo yum install -y R-core.x86_64 R-devel.x86_64

sudo yum install -y cmake 
sudo yum install -y tmux tmux-top
sudo yum install -y readline-devel libxml2-devel
sudo yum install -y java-1.8.0-openjdk*
sudo yum install -y libcurl-devel openssl-devel 
sudo yum install -y pcre-devel.x86_64 pcre-tools.x86_64
sudo yum install -y pandoc pango.x86_64 
sudo yum install -y rrdtool-tcl.x86_64 tcl-devel.x86_64

sudo yum install -y gcc-c++


sudo yum install -y \
    xterm.x86_64 \
    xorg-x11* \
    dbus-x11.x86_64 \
    libX*
    
sudo yum install -y \
    libpng-devel.x86_64 \
    libpng.x86_64 \
    libpng-static.x86_64 \
    optipng.x86_64
  
sudo yum install -y \
    cairo.x86_64 \
    cairo-devel.x86_64 \
    cairo-tools.x86_64

sudo yum install -y \
    libgeotiff.x86_64 \
    libgeotiff-devel.x86_64 \
    libtiff.x86_64 \
    libtiff-devel.x86_64

sudo yum install -y \
    openjpeg.x86_64 \
    openjpeg-libs.x86_64 \
    openjpeg-devel.x86_64
    
sudo yum install -y \
    atop.x86_64 \
    sysstat

sudo yum install -y \
    udunits2 \
    udunits2-devel.x86_64
        
```



## Setup My Linux Environmental Variables 


```bash

mkdir $HOME/Setup
cd $HOME/Setup
git clone https://github.com/Jadamso/DesktopInstall.git


PDIR=$HOME/Setup/DesktopInstall/ProfileFiles
cd $PDIR
cp $(ls -A $PDIR) $HOME
source $HOME/.bashrc

```
<!--
sudo sed -i 's/dnf/yum/g' ~/Setup/DesktopInstall/YumPrograms.sh
bash ~/Setup/DesktopInstall/YumPrograms.sh
-->


# Shiny Server Setup

## Make Dedicated User for Hosting Shiny Experiments

```bash 

sudo useradd -r -m shiny
sudo passwd -d shiny

    ## to uncomment %wheel
    #https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux_OpenStack_Platform/2/html/Getting_Started_Guide/ch02s03.html
    # sudo visudo
sudo usermod -aG wheel shiny

sudo cp $HOME/.gitconfig /home/shiny
    #sudo cp ~/.bashrc_PC /home/shiny/.bashrc
    #sudo chmod 777 /srv/shiny-server

sudo cp $HOME/Rprofile.site /home/shiny/.Rprofile
    #.libPaths("~/R-Libs")

    ## Let Shiny Own copied Library
sudo mkdir /home/shiny/R-Libs
sudo mkdir ~/R-Libs
sudo cp -r $HOME/R-Libs /home/shiny/R-Libs
sudo chmod 777 /home/shiny/R-Libs
sudo chown -R shiny:shiny  /home/shiny/R-Libs
    
```



## Install Commonly Used Programs for Shiny User

<!-- SSH directly into shiny
sudo mkdir  /home/shiny/.ssh
sudo cp ~/.ssh/authorized_keys /home/shiny/.ssh/authorized_keys
-->


```bash
su - shiny

mkdir $HOME/Setup

cd ~
git clone https://github.com/Jadamso/Programs.git


cd $HOME/Setup
git clone https://github.com/Jadamso/DesktopInstall.git


PDIR=~/Setup/DesktopInstall/ProfileFiles
cd $PDIR
cp $(ls -A $PDIR) $HOME
source ~/.bashrc

echo 'alias R="R --no-save"' >>  ~/.bashrc

cd $HOME/Setup
git clone https://github.com/Jadamso/ClusterInstall
cd $HOME/Setup/ClusterInstall

#### Linux Utilities
bash UtilsSetup.sh
bash StorageSetup.sh
    #<!--
    #bash SyncSetup.sh
    #bash CompressSetup.sh
    #bash MathSetup.sh
    #bash LatexSetup.sh
    #-->

#### Geo-Statistical Software
bash OSGEOSetup.sh
bash RSetup2.sh
bash RPostInstallSetup.sh


must edit .bashrc path to include $HOME/.local/bin
echo 'PATH=$PATH:$HOME/.local/bin' >> .bashrc
echo 'export TERM=xterm-256color' | sudo tee --append /etc/profile

```

<!--echo -e '
## Bash Profile

echo -e '\n    ## Custom Coloring' >> .bashrc
echo -e '
    PScol="\[$(tput bold)\]\[$(tput setaf 008)\]"
    PSbreak="$PScol@"
    PSuser="$PScol\u\[\033[0m\]"
    PSlocation="$PScol\W\[\033[0m\]"
    PStime="$PScol\t\[\033[0m\]" # '\033[1m\A\033[0m'
    PSdevice="$PScol\h\[\033[0m\]"
    PSstart="$PScol[\[\033[0m\]"
    PSend="$PScol]\$\[\033[0m\] "
    PS1="$PSstart$PSuser$PSbreak$PSdevice $PSlocation$PSend"
    '>> .bashrc


. $HOME/.bashrc
-->

<!--
## Allow users to run any commands anywhere 
ec2-user    ALL=(ALL)       ALL
' | sudo tee -a /etc/sudoers
-->


## Left To Do 
Optimized Math Setup, i.e.

* https://github.com/Jadamso/DesktopInstall/MathSetup.sh
* `sudo yum install openblas-devel.x86_64 lapack64-devel.x86_64`


Cannot use a pdf viewer*

```bash

sudo yum install -y \
    openmotif.x86_64 \
    urw-fonts \
    xpdf.x86_64 \

```


# O-Tree Server Setup 

https://otree.readthedocs.io/en/latest/server/ubuntu.html

Login into Ubuntu server `ssh ubuntu@XX.XXX.XXX.XXX`

Update all programs. When asked, "keep the local version"
```bash

sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get install software-properties-common
sudo apt-get install python-apt

```


## Monitoring From AWS

Follow the instructions here, https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mon-scripts.html

```bash

sudo apt-get install unzip
sudo apt-get install libwww-perl libdatetime-perl
cd $HOME
curl https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip -O
unzip CloudWatchMonitoringScripts-1.2.2.zip && \
rm CloudWatchMonitoringScripts-1.2.2.zip && \
cd aws-scripts-mon
```

To post server metric every 5 minutes, manually append the crontab file `crontab -e` with
```bash
## Post Server Metrics Every 5 Minutes
 */5 * * * * ~/aws-scripts-mon/mon-put-instance-data.pl --mem-util --disk-space-util --disk-path=/ --from-cron 
```

Open the CloudWatch console at https://console.aws.amazon.com/cloudwatch/

## Python Setup

Install Python 3.7
```bash 

sudo apt-get install -y \
    python3-pip \
    python3.7 \
    python3.7-dev \
    python3.7-venv

```

Declare Python3
```bash
sudo update-alternatives  --set python3  /usr/bin/python3.7
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2
sudo update-alternatives --config python3

```

Install Python3 Package Updater
```
python3 -m pip install pip
pip3 install --upgrade pip
```

## Database Server Setup

install server programs

```bash 

sudo apt-get install -y \
    libpq-dev \
    postgresql \
    postgresql-contrib \
    redis-server \
    git

```

setup postgres

```bash

sudo su - postgres
    psql 
        CREATE DATABASE django_db;
        alter user postgres password 'password';
        \q
    exit
    
echo 'export DATABASE_URL=postgres://postgres:postgres@localhost/django_db' >> ~/.bashrc

```

allow web-traffic in `hba_auth.conf`

```bash

sudo vim /etc/postgresql/$(ls /etc/postgresql)/main/pg_hba.conf
## manually change the `METHOD` from `md5` to `trust` for lines `IPv4` and `IPv6`.
sudo service postgresql restart

```


## Install O-Tree

```bash
pip3 install -U otree
```

*For specific details, see* https://otree.readthedocs.io/en/latest/server/ubuntu.html

```bash
echo  PATH="$PATH:$HOME/.local/bin" >> ~/.bashrc
echo 'alias python=python3.7' >> ~/.bashrc
echo 'alias pip=pip3' >> ~/.bashrc
```


<!-- Setup for Cent-OS
sudo yum install -y \
    python3-pip \
    python3-dev.x86_64 \
    libpq-dev \
    postgresql \
    postgresql-contrib \
    redis-server 

sudo yum install epel-release yum-utils
sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum-config-manager --enable remi
sudo yum install redis-devel.x86_64
-->

