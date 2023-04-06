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
  echo -e "\n\n${yellowColour}[!]${endColour} ${grayColour}Saliendo...${endColour}\n"
  tput cnorm; exit 1
}
                                                                                        
# Ctrl+C
trap ctrl_c INT

# Borrar pantalla
tput -x clear

echo -e "\n${blueColour}"
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

echo -e "\n${endColour}"

nOpcion=0

echo -e "${blueColour}[+]${endColour}${grayColour}Elija una opción para mostrar su ayuda${endColour}\n"

echo -e "${blueColour}1-${endColour}${grayColour}Metaesploit${endColour}"
echo -e "${blueColour}2-${endColour}${grayColour}Nessus${endColour}"
echo -e "${blueColour}3-${endColour}${grayColour}${endColour}"
echo -e "${blueColour}99-${endColour}${grayColour}Atajos${endColour}"
echo -ne "\n${grayColour}Opción Nº -> ${endColour}${blueColour}" && read nOpcion

echo -e "\n"

case $nOpcion in
  1)
    echo -e "${blueColour}Ayuda para Metaesploit${endColour}${grayColour}"
    echo -e "${blueColour}1.-Iniciar Base de Datos SQL \t\t ${endColour}${grayColour}service postgresql start${endColour}"
    echo -e "${blueColour}2.-Iniciar Base de Datos Metasploit \t ${endColour}${grayColour}msfdb init${endColour}"
    echo -e "${blueColour}3.-Iniciar Metasploit \t\t\t ${endColour}${grayColour}msfconsole${endColour}";;
  2)
    echo -e "${blueColour}Ayuda para Nessus${endColour}${grayColour}"
    echo -e "${blueColour}Iniciar el servicio \t\t\t${endColour}${grayColour}/bin/systemctl start nessusd.service${endColour}"
    echo -e "${blueColour}Abrir link\t\t\t\t${endColour}${grayColour}https://kali-os:8834/${endColour}"
    echo -e "${blueColour}Usuario\t\t\t\t\t${endColour}${grayColour}JohnTiger${endColour}"
    echo -e "${blueColour}Password\t\t\t\t${endColour}${grayColour}prueba123${endColour}";;
  3)
    echo -e "${blueColour}[+]${endColour}${grayColour}Elegida opción 1${endColour}";;
  4)
    echo -e "${blueColour}[+]${endColour}${grayColour}Elegida opción 1${endColour}";;
  5)
    echo -e "${blueColour}[+]${endColour}${grayColour}Elegida opción 1${endColour}";;
esac


