#!/bin/bash
# ipcheck.sh file
# perform check whether rasp pi connected to the internet

tput sgr0 #restore terminal to normal
clear #clear screen

#settings
err=0 #set error flag
wlan='wlan0'
pingip='raspberrypi.org'
RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

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
    
    echo "${GREEN}Current local IP address:"; hostname --all-ip-addresses
    echo "${GREEN}Current public IP address:"; curl icanhazip.com

    tput sgr0 #restore terminal to normal 
fi

#check if any errors detected
if [ $err != 0 ];
then
  echo "${RED}$err error(s) detected during ipcheck script."
else
  echo "${GREEN}No errors detected during ipcheck script."
fi

tput sgr0 #restore terminal to normal

exit 0
