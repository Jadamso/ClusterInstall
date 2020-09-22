#------------------------------------------------------------------
#########################
# Enviroment Setup 
#########################
## For Cluster 
if [[ $HOME == "/home/jadamso" ]] ; then
	SUDO=""
    module rm intel
## For Personal
elif [[ $HOME == "/home/Jadamso" ]] ; then
	SUDO=sudo
else
	SUDO=sudo
fi

PREFIX=$HOME


#------------------------------------------------------------------
#########################
# Colors Setup 
#########################
s0="\e[1;92m"
s00="\e[92m"
s1="\e[0m\n"


#------------------------------------------------------------------
#########################
# Trial 
#########################

# cd /tmp
# echo -e '#!/bin/bash\n source "EnvironmentSetup.sh" \n echo $SUDO' > TEMP.sh
# cp ~/Setup/ClusterInstall/EnvironmentSetup.sh /tmp
# bash TEMP.sh
