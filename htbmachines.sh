#!/bin/bash

# Enlace web S4vitar -> https://htbmachines.github.io/


# Variables Globales
main_url="https://htbmachines.github.io/bundle.js"

# Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


function ctrl_c(){
  echo -e "\n\n${redColour}[!]${endColour} ${yellowColour}Saliendo...${endColour}\n"
  tput cnorm && exit 1
}

# Crtl+C
trap ctrl_c INT

function helpPanel(){
  echo -e "\n${yellowColour}[+]${endColour} ${grayColur} Uso:${endColour}"
  echo -e "\t${purpleColour}u)${endColour} ${greyColour} Descargar o actualizar archivos necesarios${endColour}"
  echo -e "\t${purpleColour}m)${endColour} ${greyColour} Buscar por un nombre de máquina${endColour}"
  echo -e "\t${purpleColour}i)${endColour} ${greyColour} Buscar por dirección IP${endColour}"
  echo -e "\t${purpleColour}d)${endColour} ${greyColour} Buscar por dificultad${endColour}"
  echo -e "\t${purpleColour}o)${endColour} ${greyColour} Buscar por el sistema operativo${endColour}"
  echo -e "\t${purpleColour}s)${endColour} ${greyColour} Buscar por skill${endColour}"
  echo -e "\t${purpleColour}y)${endColour} ${greyColour} Obtener link de la resolución de la máquina en Youtube${endColour}"
  echo -e "\t${purpleColour}h)${endColour} ${greyColour} Mostrar este panel de ayuda${endColour}\n"
}

function updateFiles(){
  tput civis
  echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Comprobando si hay actualizaciones pendientes...${endColour}\n"
  if [ ! -f bundle.js ]; then
    echo -e "${yellowColour}[+]${endColour} ${grayColour}Descargando los archivos necesarios...${endColour}\n"
    curl -s $main_url > bundle.js
    js-beautify bundle.js | sponge bundle.js
    echo -e "${yellowColour}[+]${endColour} ${grayColour}Todos los archivos han sido descargados${endColour}\n"
  else
    curl -s $main_url > bundle_temp.js
    js-beautify bundle_temp.js | sponge bundle_temp.js
    md5_temp_value=$(md5sum bundle_temp.js | awk '{print $1}')
    md5_original_value=$(md5sum bundle.js | awk '{print $1}')
    if [ "$md5_temp_value" == "$md5_original_value" ]; then
      rm bundle_temp.js
      echo -e "${yellowColour}[+]${endColour} ${grayColour}No hay actualizaciones${endColour}"
    else
      rm bundle.js && mv bundle_temp.js bundle.js
      echo -e "${yellowColour}[+]${endColour} ${grayColour}Datos actualizados${endColour}"
    fi
  fi
  tput cnorm
}



function searchMachine(){
  machineName="$1"
  name=$(cat bundle.js| awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta:" | tr -d '"' | tr -d ',' | sed 's/^ * //' | grep name | sed 's/name: //')
  if [ "$name" ]; then
    ip=$(cat bundle.js| awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta:" | tr -d '"' | tr -d ',' | sed 's/^ * //' | grep ip | sed 's/ip: //')
    so=$(cat bundle.js| awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta:" | tr -d '"' | tr -d ',' | sed 's/^ * //' | grep so | sed 's/so: //')
    difi=$(cat bundle.js| awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta:" | tr -d '"' | tr -d ',' | sed 's/^ * //' | grep dificultad | sed 's/dificultad: //')
    skill=$(cat bundle.js| awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta:" | tr -d '"' | tr -d ',' | sed 's/^ * //' | grep skills | sed 's/skills: //')
    style=$(cat bundle.js| awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta:" | tr -d '"' | tr -d ',' | sed 's/^ * //' | grep like | sed 's/like: //')
    yout=$(cat bundle.js| awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta:" | tr -d '"' | tr -d ',' | sed 's/^ * //' | grep youtube | sed 's/youtube: //')
    ad=$(cat bundle.js| awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta:" | tr -d '"' | tr -d ',' | sed 's/^ * //' | grep directory | sed 's/activeDirectyroy: //')
    
    echo -e "\n${yellowColour}[+]${endColour} ${greyColour}Listando las propiedades de la máquina ${endColour}${blueColour}$machineName:${endColour}\n"
    echo -e "${blueColour}    Nombre: ${endColour}${grayColour}$name${endColour}"
    echo -e "${blueColour}    Dirección IP: ${endColour}${grayColour}$ip${endColour}"
    echo -e "${blueColour}    Sistema Operativo: ${endColour}${grayColour}$so${endColour}"
    echo -e "${blueColour}    Dificultad: ${endColour}${grayColour}$difi${endColour}"
    echo -e "${blueColour}    Skill: ${endColour}${grayColour}$skill${endColour}"
    echo -e "${blueColour}    Estilo: ${endColour}${grayColour}$style${endColour}"
    echo -e "${blueColour}    Youtube: ${endColour}${grayColour}$yout${endColour}"
    echo -e "${blueColour}    Active Directorry: ${endColour}${grayColour}$ad${endColour}"
  else
    echo -e "\n${yellowColour}[!]${endColour}${redColour} La máquina llamada ${endColour}${blueColour}$machineName${endColour}${redColour} no ha sido encontrada${endColour}"
  fi
}

function searchIP(){
  ipAddress="$1"
  machineName=$(cat bundle.js | grep "ip: \"$ipAddress\"" -B 3 | grep "name" | tr -d "," | tr -d '"' | awk 'NF{print $NF}')
  if [ $machineName ]; then
    echo -e "\n${yellowColour}[+] ${endColour}${blueColour}El nombre de la máquina es: ${endColour}${grayColour}$machineName${endColour}"
    echo -e "    ${blueColour}La dirección IP es:${endColour} ${grayColour}$ipAddress${endColour}"
  else    
    echo -e "\n${yellowColour}[!]${endColour}${redColour} La máquina con la ip ${endColour}${blueColour}$ipAddress${endColour}${redColour} no ha sido encontrada${endColour}"
  fi
}

function getYoutubeLink(){
  machineName="$1"
  yt=$(cat bundle.js| awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta:" | tr -d '"' | tr -d ',' | sed 's/^ * //' | grep "youtube" | awk 'NF{print $NF}')
  
  if [ "$yt" ]; then
    echo -ey "\n${yellowColour}[+] ${endColour}${blueColour}El nombre de la máquina es:${endColour} ${grayColour}$machineName${endColour}"
    echo -e "    ${blueColour}El link es:${endColour} ${grayColour}$yt${endColour}"
  else
    echo -e "\n${yellowColour}[!]${endColour}${redColour} La máquina llamada ${endColour}${blueColour}$machineName${endColour}${redColour} no se ha encontrado su enlace de Youtbue${endColour}"
  fi
}

function getMachinesDifficulty(){
  di="$1"
  machines=$(cat bundle.js | grep "dificultad: \"$1"\" -B 5 | grep name | tr -d '"' | tr -d ',' | awk 'NF{print $NF}' | column)
echo -e "jp"
  if [ "$machines" ]; then
    echo -e "\n${yellowColour}[+] ${endColour}${grayColour}Las máquinas encontradas con dificultad ${endColour}${blueColour}$di${endColour}${grayColour} son:${endColour}\n"
    if [ $di == "Fácil" ]; then
      echo -e "${grayColour}$machines${endColour}\n"
    elif [ $di == "Media" ]; then
      echo -e "${greenColour}$machines${endColour}\n"
    elif [ $di == "Difícil" ]; then
      echo -e "${yellowColour}$machines${endColour}\n"
    elif [ $di == "Insane" ]; then
      echo -e "${redColour}$machines${endColour}\n"
    fi
  else 
    echo -e "\n${yellowColour}[!]${endColour}${redColour} No se han encontrado máquinas con dificultad ${endColour}${blueColour}$di${endColour}\n"
  fi
}

function showAllMachines(){
  fa=$(cat bundle.js | grep "dificultad: \"Fácil"\" -B 5 | grep name | tr -d '"' | tr -d ',' | awk 'NF{print $NF}' | column)
  me=$(cat bundle.js | grep "dificultad: \"Media"\" -B 5 | grep name | tr -d '"' | tr -d ',' | awk 'NF{print $NF}' | column)
  di=$(cat bundle.js | grep "dificultad: \"Difícil"\" -B 5 | grep name | tr -d '"' | tr -d ',' | awk 'NF{print $NF}' | column)
  in=$(cat bundle.js | grep "dificultad: \"Insane"\" -B 5 | grep name | tr -d '"' | tr -d ',' | awk 'NF{print $NF}' | column)

  echo -e "\n${blueColour}[+] ${endColour}${grayColour}Las máquinas con dificultad Fácil son:${endColour}"
  echo -e "${grayColour}$fa${endColour}\n"

  echo -e "\n${blueColour}[+] ${endColour}${greenColour}Las máquinas con dificultad Media son:${endColour}"
  echo -e "${greenColour}$me${endColour}\n"

  echo -e "\n${blueColour}[+] ${endColour}${yellowColour}Las máquinas con dificultad Difícil son:${endColour}"
  echo -e "${yellowColour}$di${endColour}\n"

  echo -e "\n${blueColour}[+] ${endColour}${redColour}Las máquinas con dificultad Insane son:${endColour}"
  echo -e "${redColour}$in${endColour}\n"
}

function getOSMachines(){
  os="$1"
  machineName=$(cat bundle.js | grep "so: \"$os"\" -B 5 | grep name | tr -d '"' | tr -d ',' | awk 'NF{print $NF}' | column)

  if [ "$machineName" ]; then
    echo -e "\n${yellowColour}[+] ${endColour}${grayColour}Las máquinas con sistema operativo ${endColour}${blueColour}$os${endColour}${grayColour} son:${endColour}\n"
    echo -e "${grayColour}$machineName${endColour}\n"
  else
    echo -e "\n${yellowColour}[!]${endColour}${redColour} No se han encontrado máquinas con el sistema operativo ${endColour}${blueColour}$os${endColour}\n"
  fi
}

function getOSDifficulty(){
  os="$1"
  difficulty="$2"
  machineName=$(cat bundle.js | grep "dificultad: \"$difficulty\"" -B 5 -i | grep "so: \"$os\"" -B 4 | grep name | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column)

  if [ "$machineName" ]; then
    echo -e "\n${yellowColour}[+] ${endColour}${grayColour}Las máquinas con sistema operativo ${endColour}${blueColour}$os${endColour}${grayColour} y dificultad ${blueColour}$difficulty${endColour}${grayColour} son:${endColour}\n"
    
    if [ $difficulty == "Fácil" ]; then
      echo -e "${grayColour}$machineName${endColour}\n"
    elif [ $difficulty == "Media" ]; then
      echo -e "${greenColour}$machineName${endColour}\n"
    elif [ $difficulty == "Difícil" ]; then
      echo -e "${yellowColour}$machineName${endColour}\n"
    elif [ $difficulty == "Insane" ]; then
      echo -e "${redColour}$machineName${endColour}\n"
    fi

  else
      echo -e "\n${yellowColour}[!]${endColour}${redColour} No se han encontrado máquinas con el sistema operativo ${endColour}${blueColour}$os${endColour}${redColour} y con la dificultad ${blueColour}$difficulty${endColour}"
  fi
}

function getSkill(){
  skill="$1"
  machineName=$(cat bundle.js | grep "skills: " -B 6 | grep "$skill" -i -B 6 | grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column)
  if [ "$machineName" ]; then
    echo -e "\n${yellowColour}[+] ${endColour}${grayColour}Las máquinas con la skill ${endColour}${blueColour}$skill${endColour}${grayColour} son:${endColour}\n"
    echo -e "${grayColour}$machineName${endColour}\n"
  else
    echo -e "\n${yellowColour}[!]${endColour}${redColour} No se han encontrado máquinas con la skill ${endColour}${blueColour}$skill${endColour}\n"
  fi

}

# Chivatos
declare -i chivato_difficulty=0
declare -i chivato_os=0


# Indicadores
declare -i parameter_counter=0

while getopts "m:ui:y:d:ao:s:h" arg; do
 case $arg in 
    m) machineName="$OPTARG"; let parameter_counter+=1;;
    u) let parameter_counter+=2;;
    i) ipAddress="$OPTARG"; let parameter_counter+=3;;
    y) machineName="$OPTARG"; let parameter_counter+=4;;
    d) difficulty="$OPTARG"; chivato_difficulty=1; let parameter_counter+=5;;
    o) os="$OPTARG"; chivato_os=1; let parameter_counter+=6;;
    s) skill="$OPTARG"; parameter_counter+=7;;
    a) let parameter_counter+=10;;
    h) ;;
 esac
done

if [ $parameter_counter -eq 1 ]; then
  searchMachine $machineName
elif [ $parameter_counter -eq 2 ]; then
  updateFiles
elif [ $parameter_counter -eq 3 ]; then
  searchIP $ipAddress
elif [ $parameter_counter -eq 4 ]; then
  getYoutubeLink $machineName
elif [ $parameter_counter -eq 5 ]; then
  getMachinesDifficulty $difficulty
elif [ $parameter_counter -eq 6 ]; then
  getOSMachines $os
elif [ $parameter_counter -eq 7 ]; then
  getSkill "$skill"
elif [ $parameter_counter -eq 10 ]; then
  showAllMachines
elif [ $chivato_difficulty -eq 1 ] && [ $chivato_os -eq 1 ]; then
  getOSDifficulty $os $difficulty
else
  helpPanel
fi



