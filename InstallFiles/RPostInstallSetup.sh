source "EnvironmentSetup.sh"
#------------------------------------------------------------------
##################
# Check R Setup
##################

## Library
mkdir ~/R-Libs

## Rprofile
#sudo cp ~/Rprofile.site ~/lib64/R/etc/Rprofile.site ## Source Build
#sudo cp ~/Rprofile.site /usr/lib64/R/etc/Rprofile.site ## Repo Build
#~/Desktop/Packages/ClusterInstall/ProfileFiles/Rprofile.site

## Java
#$SUDO R CMD javareconf 
R CMD javareconf -e

## Rprofile
#http://www.r-bloggers.com/fun-with-rprofile-and-customizing-r-startup/
#http://www.r-bloggers.com/customize-your-rprofile-and-keep-your-workspace-clean/
#http://www.noamross.net/blog/2012/11/2/rprofile.html

#------------------------------------------------------------------
##################
# Manually Install Initial Packages
##################

## Almost Always
R --slave -e 'install.packages( c("digest") )'
R --slave -e 'install.packages( c("devtools") )'
R --slave -e 'install.packages( c("curl") )'
R --slave -e 'devtools::install_github("jalvesaq/colorout")'
R --slave -e 'install.packages("udunits2", configure.args="--with-udunits2-include=/usr/include/udunits2")'

#------------------------------------------------------------------
##################
# Install All Previous Packages
##################

## All Previously Installed in .libPaths()
R -e 'install.packages(
    pkgs=as.data.frame(installed.packages(.libPaths()),
        stringsAsFactors=FALSE)$Package,
    lib=lib,    
    type="source")'
#files=$(ls ~/R-Libs); for pack in $files
#lib <- t( read.csv("Rlibs.txt", sep=" ", header=F) )


## My Custom Packages
for pack in AncientR GradeR GeoCleanR MiscUtils PrettyR SpatialHHI STrollR SetupGameR SpatialGameR TerritoryR
do
#git clone https://github.com/Jadamso/$pack.git
R -e "devtools::install(paste0(path.expand('~/Desktop/Packages/'),\"$pack/$pack\"),force=TRUE, dependencies=TRUE)"
done

## My Public Packages
#devtools::install_github("Jadamso/STrollR",subdir="STrollR")
#devtools::install_github("Jadamso/PrettyR",subdir="PrettyR")
#devtools::install_github("Jadamso/GeoCleanR",subdir="GeoCleanR")

#------------------------------------------------------------------
##################
# Install Packages from Scratch
##################

## Common
for pack in roxygen2 RCurl Matrix abind mgcv spam spam64 sp maptools raster rgeos rgdal spatstat sf fields gdalUtils cleangeo doMC foreach stargazer reshape2 plyr pryr operators data.table formattable gridExtra ggplotify sandwich
do
R -e "install.packages(\"$pack\")"
done


## Shiny
R -e 'install.packages(c("xtable", "htmltools", "sourcetools", "httpuv"))'
R -e 'install.packages(c("rmarkdown"))'
R -e 'devtools::install_github("rstudio/shiny")'

#Warning: Error in pngfun: X11 is not available

#$SUDO chmod 777 $HOME/lib64/R/library

#------------------------------------------------------------------
##################
# Old Misc
##################

# on PC w/ source build
# sudo cp ~/Rprofile.site ~/lib64/R/etc/Rprofile.site 

# on PC w/ yum build
# sudo cp ~/Rprofile.site /usr/lib64/R/etc/Rprofile.site 

## on PC with revolution source build
## sudo cp ~/Rprofile.site $HOME/microsoft-r-open-MRO-3.3.1/source/etc/Rprofile.site

#on Cluster
## Upload Main
## cp ~/Rprofile.site $HOME/lib64/R/etc/Rprofile.site ## without MKL
## cp ~/Rprofile.site $HOME/microsoft-r-open-MRO-3.3.1/source/etc/Rprofile.site ##  with MKL 

## Make sure:
# mkdir -p ~/lib64/R/library
# sudo chmod -R a+w ~/lib64/R/library
# sudo chmod -R a+w ~/lib64/R/

# Formerly: .libPaths( c( .libPaths(), paste0("~/R/x86_64-pc-linux-gnu-library/", version$minor ) ))
