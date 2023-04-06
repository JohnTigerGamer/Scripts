#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
orangeColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){
  echo -e "\n\n${redColour}[!]${endColour} ${grayColour}Operación abortada${endColour}\n"
  tput cnorm; exit 1
}
                                                                                        
# Ctrl+C
trap ctrl_c INT

tput -x clear

echo -e "${blueColour}"
echo -e "  ===================================================  "
echo -e "||       _       _        _______ _                  ||"
echo -e "||      | |     | |      |__   __(_)                 ||"
echo -e "||      | | ___ | |__  _ __ | |   _  __ _  ___ _ __  ||"
echo -e "||  _   | |/ _ \| '_ \| '_ \| |  | |/ _' |/ _ \ |__| ||"
echo -e "|| | |__| | (_) | | | | | | | |  | | (_| |  __/ |    ||"
echo -e "||  \____/ \___/|_| |_|_| |_|_|  |_|\__, |\___|_|    ||"
echo -e "||                                   __/ |           ||"
echo -e "||                                  |___/            ||"
echo -e "  ===================================================  "

echo -e "\n${endColour}"

echo -e "${blueColour}[+]${endColour}${grayColour} Ha continuación se iniciará Metasploit${endColour}"
echo -e "${blueColour}[+]${endColour}${grayColour} Iniciar Base de Datos SQL${endColour}"
sudo service postgresql start
sleep 5
echo -e "${blueColour}[+]${endColour}${grayColour} Iniciar Base de Datos de Metasploit${endColour}"
sudo msfdb init
sleep 5
echo -e "${blueColour}[+]${endColour}${grayColour} Iniciar Metasploit${endColour}"
msfconsole

