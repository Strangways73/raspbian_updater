#!/bin/bash
# RASPBERRY PI UPDATE SCRIPT
# LAST UPDATED 17/3/18
# 11/1/18 added update for raspi-config
# 12/1/18 added new update types
# 17/3/18 added new clean and autoremove commands

#reset terminal to normal
tput sgr0 #restore terminal to normal

#clear screen
clear

#show date
date

#settings
err=0 #set error flag
wlan='wlan0'
pingip='raspberrypi.org'
RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

############################
# FUNCTIONS
############################
errcheck () {

if [ $? != 0 ]; 
then
    echo "${RED}Last command did not complete successfully"
    sleep 3
    err=$((err+1)) #incremet error flag, report errors and don't exit otherwise the remaining script commands will not run
fi

}

############################
# MAIN SCRIPT
############################

# perform check of wifi connection
echo "${GREEN}Performing Network check for $wlan"
tput sgr0 #restore terminal to normal

/bin/ping -c 2 -I $wlan $pingip > /dev/null 2> /dev/null

if [ $? -ge 1 ] ; then
    echo "${RED}Network connection down! Attempting reconnection."
    /sbin/ifdown $wlan
    /bin/sleep 5
    /sbin/ifup --force $wlan
    tput sgr0 #restore terminal to normal
    err=$((err+1)) #incremet error flag, report errors and don't exit otherwise the remaining script commands will not run
else
    echo "${GREEN}Network is Okay"
    tput sgr0 #restore terminal to normal
    
    echo "${GREEN}Current IP address:"; hostname --all-ip-addresses
    tput sgr0 #restore terminal to normal
    
    sudo dpkg --configure -a    
    errcheck
    echo  "${GREEN}DPKG configure completed" 
    tput sgr0 #restore terminal to normal   
    
    sudo apt-get autoclean
    errcheck
    sudo apt-get clean
    errcheck
    echo  "${GREEN}Autoclean completed"
    tput sgr0 #restore terminal to normal    
    
    sudo apt-get update -yq
    errcheck
    echo  "${GREEN}Update completed"
    tput sgr0 #restore terminal to normal
    
    sudo apt-get upgrade -yq
    errcheck
    echo "${GREEN}Upgrade completed"
    tput sgr0 #restore terminal to normal
    sudo apt-get dist-upgrade -yq
    errcheck
    echo "${GREEN}Dist upgrade complete"
    tput sgr0 #restore terminal to normal
    
    sudo apt-get install raspi-config -yq #update raspi-config utility
    errcheck
    echo "${GREEN}Raspi-config updated"
    tput sgr0 #restore terminal to normal
    
    sudo apt-get install rpi-update
    sudo rpi-update
    errcheck
    echo  "${GREEN}Firmware update complete"
    tput sgr0 #restore terminal to normal
    
    sudo apt-get --purge autoremove 
    errcheck
    sudo apt-get autoremove
    errcheck
    echo "${GREEN}Autoremove completed"
    tput sgr0 #restore terminal to normal
fi

#check if any errors detected
if [ $err != 0 ];
then
  echo "${RED}$err error(s) detected during update script."
else
  echo "${GREEN}No errors detected during update script."
fi

tput sgr0 #restore terminal to normal

exit 0
