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

echo -e "\n"
echo -e " ================================================= "
echo -e "|      _       _        _______ _                 |"
echo -e "|     | |     | |      |__   __(_)                |"
echo -e "|     | | ___ | |__  _ __ | |   _  __ _  ___ _ __ |"
echo -e "| _   | |/ _ \| '_ \| '_ \| |  | |/ _' |/ _ \ |__||"
echo -e "|| |__| | (_) | | | | | | | |  | | (_| |  __/ |   |"
echo -e "| \____/ \___/|_| |_|_| |_|_|  |_|\__, |\___|_|   |"
echo -e "|                                  __/ |          |"
echo -e "|                                 |___/           |"
echo -e " ================================================= "
                                                               
tput civis  # Al inicio

function ctrl_c(){
  echo -e "\n\n${yellowColour}[!]${endColour} ${grayColour}Saliendo...${endColour}\n"
  tput cnorm; exit 1
}
                                                                                        
# Ctrl+C
trap ctrl_c INT

dataRangue=""

echo -ne "\n${blueColour}[+]${endColour}${grayColour} Indique el rango de ips en el que desea buscar ${endColour}-> " && read dataRangue

echo -e "\n${blueColour}[+]${endColour}${grayColour} Realizando Escaneo espere por favor${endColour}\n"


# ip=$(ip a | grep eth0 | tail -n 1 | awk '{print $2}' | cut -d '/' -f 1 )
# echo -e "ip $ip"


nmap -sn $dataRangue/24 | grep "Nmap scan" | awk 'NF{print $NF}' > file.txt

for i in $(cat file.txt); do echo -e "${blueColour}[+]${endColour}${grayColour} Existe conexión con la ip ${endColour}${blueColour}$i${endColour}"; done

rm -r file.txt

echo -e "\n"

tput cnorm  # Al finalizar

