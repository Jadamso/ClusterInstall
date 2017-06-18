# ClusterInstall
Install instructions for my scientic programs on a computer cluster

    cd $HOME/InstallSetup
    git clone https://github.com/Jadamso/ClusterInstall



#### Does not work yet on Scientific Linux 7.3


# Headless Setup for Clusters

*must use wget not git for Headless*

*git version 1.8 lacks support for https*

    export IDIR="$HOME/InstallSetup/InstallInstructions/Cluster"
    cd $IDIR


## Setup Bash Environment

make sure .bashrc, .bashrc_PC, .bashrc_CLUSTER are available in $HOME

    PDIR=$HOME/InstallSetup/ClusterInstall/ProfileFiles
    cd $PDIR
    cp $(ls -A $PDIR) $HOME
    cat $HOME/.bashrc_CLUSTER


append your $HOME/.bashrc with
    source $HOME/.bashrc_COMMON
	source $HOME/.bashrc_CLUSTER

## Download Programs

    cd ~
    git clone https://github.com/Jadamso/Programs.git


## Math Setup for Local Machines

*uses --prefix=$HOME*

    bash GCCSetup.sh *is still Problematic*
    bash MathSetup.sh *OpenBLAS, ATLAS has problems* *hwloc works*
    bash PythonSetup.sh *creates problems*

*GCC does not work on SL7.1 or SL7.3*
*gccgo: error: ../x86_64-pc-linux-gnu/libgo/zstdpkglist.go:    No such file or directory*


## Cluster Setup

*must set PREFIX for ClusterSetup*

    export PREFIX=$HOME

    bash ClusterSetup1.sh
        #bash UtilsSetup.sh *works*
        #bash SyncSetup.sh *works*
        #bash TMUXSetup.sh *works*

#### Does not work yet: bash ClusterSetup2.sh
    bash ClusterSetup2.sh
        bash CompressSetup.sh *works*
        bash OSGEOSetup.sh *NetCDF, GEOS, GDAL does not work*
        bash RSetup.sh *does not work*


#### Some Other Desireable Software Pseudo Guides
    bash EvinceSetup.sh
    bash LatexSetup.sh
    bash GitHubSetup.sh
    bash SSHSetup.sh
    bash StorageSetup.sh
    bash CSVSetup.sh

