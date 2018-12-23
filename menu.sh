#!/bin/bash
################################
# menu script
# last updated 19/1/18
# 
# NOTES
# this script uses the follwoing other scripts:
# 1. update.sh
# 2. ipcheck.sh
# 3. cleanup.sh
# 4. colours.sh 
# 5. health.sh
#
# fsck scan will not scan mounted filesystem 
# 
# COPYRIGHT, GNU LICENCE & WARRANTY
# Copyright (c) 2017-2018 Michael A Robson
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA.
#
################################

################################
# VARIABLES
################################
RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

####################
# Functions
####################
 
# Wait for user keypress.
Pause()
{
 echo "Press any key to continue"
 OLDCONFIG=`stty -g`
 stty -icanon -echo min 1 time 0
 dd count=1 2>/dev/null
 stty $OLDCONFIG
}

####################
# Main Script
####################

tput sgr0 #reset terminal
clear #clear screen

while :
do

# whiptail dialog window values
# 15 height of the dialog
# 50 width of the dialog
# 8 height of the menu list
h=15
w=50
list=8

RETVAL=$(whiptail --title "Make a selection and press Enter" \
--menu --nocancel "Menu Script" $h $w $list \
"1" "Update Raspberry Pi" \
"2" "Cleanup Raspberry Pi" \
"3" "Show IP address" \
"4" "Colour test" \
"5" "Configure Raspberry Pi" \
"6" "Raspi Health Check" \
"7" "Scan SD Card" \
"8" "Quit" \
3>&1 1>&2 2>&3)

# Below you can enter the corresponding commands

case $RETVAL in
    "1") clear
       echo "${GREEN}Running update.sh file"
       tput sgr0 #reset terminal 
       sh update.sh
       Pause;;
    "2") clear
       echo "${GREEN}Running cleanup.sh file"
       tput sgr0 #reset terminal
       sudo sh cleanup.sh
       Pause;;
    "3") clear
       # perform check of wifi connection
       echo "${GREEN}Running ipcheck.sh file"
       sh ipcheck.sh
       Pause;;
    "4") clear
       echo "${GREEN}Running colours.sh file"
       tput sgr0 #reset terminal
       sh colours.sh
       Pause;;
    "5") sudo raspi-config;;
    "6") clear
       #perform health check
       echo "${GREEN}Running health.sh file"
       sh health.sh
       Pause;; 
    "7") clear
       fsck -M #scan sd card
       Pause;;
    "8") clear
       echo "${GREEN}Goodbye"
       tput sgr0 #reset terminal
       break;;
    *) echo "${RED}Invalid option. Quitting";;
esac
done
exit 0 
