
#on PC w/ source build
# sudo cp ~/Rprofile.site ~/lib64/R/etc/Rprofile.site 

# on PC w/ yum build
# sudo cp ~/Rprofile.site /usr/lib64/R/etc/Rprofile.site 

## on PC with revolution source build
## sudo cp ~/Rprofile.site  $HOME/microsoft-r-open-MRO-3.3.1/source/etc/Rprofile.site

#on Cluster
## Upload Main
## cp ~/Rprofile.site $HOME/lib64/R/etc/Rprofile.site ## without MKL
## cp ~/Rprofile.site $HOME/microsoft-r-open-MRO-3.3.1/source/etc/Rprofile.site ##  with MKL 



## Make sure:
# mkdir -p ~/lib64/R/library
# sudo chmod -R a+w ~/lib64/R/library
# sudo chmod -R a+w ~/lib64/R/


# Formerly: .libPaths( c( .libPaths(), paste0("~/R/x86_64-pc-linux-gnu-library/", version$minor ) ))


# R 'install.packages("devtools")'
# R 'devtools::install.packages("jalvesaq/colorout")'
