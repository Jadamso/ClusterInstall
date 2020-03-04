# ClusterInstall
Install instructions for my scientic programs on a computer cluster

```bash

mkdir $HOME/Setup
cd $HOME/Setup
git clone https://github.com/Jadamso/ClusterInstall

```

# Setup for Clusters

*not tested on Scientific Linux 7.3*

*If using earlier git version 1.8, lacks https support so use wget*



```bash

IDIR="$HOME/Setup/ClusterInstall"
cd $IDIR

```


## Setup Bash Environment

make sure `.bashrc`, `.bashrc_PC`, `.bashrc_CLUSTER` are available in `$HOME`

```bash

IDIR="$HOME/Setup/ClusterInstall"
PDIR=$IDIR/ProfileFiles
cd $PDIR
cp $(ls -A $PDIR) $HOME
cat $HOME/.bashrc_CLUSTER

```

optionally append your `$HOME/.bashrc` with files

```bash

echo -e 'source $HOME/.bashrc_COMMON' >> $HOME/.bashrc
echo -e 'source $HOME/.bashrc_CLUSTER' >> $HOME/.bashrc

```

## Download Programs

```bash

cd ~
git clone https://github.com/Jadamso/Programs.git

```




## Cluster Setup

*must set PREFIX for ClusterSetup*

```bash

export PREFIX=$HOME

#### Linux Utilities
bash ClusterSetup1.sh
    bash UtilsSetup.sh
    bash SyncSetup.sh
    bash TMUXSetup.sh

#### Math-From-Scratch PreReqs
#### *If Installed, The optional Math-Setup should be installed first*
#### Current Bug (See Below)
#bash ClusterSetup2.sh
#    bash CompressSetup.sh
#        *xz-5.2.3 will break yum*
#    bash MathSetup.sh
#        *bash OpenJavaDevKitSetup.sh*
#    bash MPISetup.sh

#### Geo-Statistical Software
bash ClusterSetup3.sh
    bash OSGEOSetup.sh
    bash RSetup2.sh
    bash RPostInstallSetup.sh

#### Other Desireable Software Pseudo Installs
bash EvinceSetup.sh
bash LatexSetup.sh
bash GitHubSetup.sh
bash SSHSetup.sh
bash StorageSetup.sh
    # Set up AWS to screen for password info
    # https://github.com/awslabs/git-secrets
bash CSVSetup.sh

```



## Math-From-Scratch Setup (No Longer Working)

```bash

cd $IDIR

*uses --prefix=$HOME*

bash GCCSetup.sh
*does not work on AmazonLinux*
*does not work on SL7.1 or SL7.3*

bash PythonSetup.sh *creates problems*

```
