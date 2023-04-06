#!/bin/bash

# JohnTiger 2023
# Script para Crear Pestañas


#Coloursi
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

nP=0

echo -ne "${blueColour}[+]${endColour}${grayColour} Escriba cuantas pestañas desea tener abiertas${endColour}${blueColour} -> " && read nP

# Primero Renombramos la Pestaña Actual como 0
xdotool key ctrl+shift+alt+t
for i2 in $(seq 1 30); do xdotool key BackSpace; done
xdotool key 0
xdotool key KP_Enter

# Creamos El Resto de Pestañas y Las Renombramos
for i1 in $(seq 1 $(($nP-1))); do
  xdotool key ctrl+shift+t
  xdotool key ctrl+shift+alt+t
  for i2 in $(seq 1 30); do xdotool key BackSpace; done
  xdotool key $i1
  xdotool key KP_Enter
done

# Por Último nos Desplazamos a la Pestaña Inicial
xdotool key ctrl+shift+Right

echo -e "\n${blueColour}[+]${endColour}${grayColour} Pestañas Abiertas, Disfrute de su Tiempo Hack ${endColour}${blueColour}:)${endColour}\n"
