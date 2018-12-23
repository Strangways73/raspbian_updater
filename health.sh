#!/bin/bash
# health.sh file
# check general health matters about the raspberry pi

tput sgr0 #restore terminal to normal
clear #clear screen

#settings
RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

#main script
date;
echo "${GREEN}Uptime:"
tput sgr0 #restore terminal to normal
uptime
echo "${GREEN}Currently connected:"
tput sgr0 #restore terminal to normal
w
echo "--------------------"
echo "${GREEN}Last logins:"
tput sgr0 #restore terminal to normal
last -a |head -3
echo "--------------------"
echo "${GREEN}Disk and memory usage:"
tput sgr0 #restore terminal to normal
df -h | xargs | awk '{print "Free/total disk: " $11 " / " $9}'
free -m | xargs | awk '{print "Free/total memory: " $17 " / " $8 " MB"}'
echo "--------------------"
start_log=`head -1 /var/log/messages |cut -c 1-12`
oom=`grep -ci kill /var/log/messages`
echo -n "${GREEN}OOM errors since $start_log :" $oom
tput sgr0 #restore terminal to normal
echo ""
echo "--------------------"
echo "${GREEN}Utilization and most expensive processes:"
tput sgr0 #restore terminal to normal
top -b |head -3
echo
top -b |head -10 |tail -4
echo "--------------------"
echo "${GREEN}Open TCP ports:"
tput sgr0 #restore terminal to normal
nmap -p- -T4 127.0.0.1
echo "--------------------"
echo "${GREEN}Current connections:"
tput sgr0 #restore terminal to normal
ss -s
echo "--------------------"
echo "${GREEN}Processes:"
tput sgr0 #restore terminal to normal
ps auxf --width=200
echo "--------------------"
echo "vmstat:"
vmstat 1 5

tput sgr0 #restore terminal to normal
exit 0