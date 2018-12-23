#!/bin/bash

#clear screen
clear

echo "Colour test"
#show colours
for i in 1 2 3
do
echo " \e[41m                                                                              "
done

for i in 1 2 3
do
echo " \e[42m                                                                              "
done

for i in 1 2 3
do
echo " \e[43m                                                                              "
done

for i in 1 2 3
do
echo " \e[44m                                                                              "
done

for i in 1 2 3
do
echo " \e[45m                                                                              "
done

for i in 1 2 3
do
echo " \e[46m                                                                              "
done

for i in 1 2 3
do
echo " \e[47m                                                                              "
done

for i in 1 2 3
do
echo " \e[106m                                                                              "
done

for i in 1 2 3
do
echo " \e[107m                                                                              "
done

tput sgr0 #restore terminal to normal

exit 0