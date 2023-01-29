#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

echo -e "\n    ${blueColour}[+] Esta es tu dirección Ip privada${endColour}"
echo -e "        ${redColour}$(ip a | grep eth0 | tail -n 1 | awk '{print $2}' | cut -d '/' -f 1 )\n${endColouri}"

