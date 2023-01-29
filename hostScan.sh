#!/bin/bash

function ctrl_c(){
  echo -e "\n\n[!] Saliendo...\n"
  tput civis; exit 1
}

# Ctrl+C
trap ctrl_c INT

# Ocultar cursor mientras se ejecuta el script
tput civis

for i in $(seq 0 254); do
  timeout 1 bash -c "ping -c 1 192.168.1.$i &>/dev/null" && echo "[+] Host 192.168.1.$i - ACTIVE" &
done;wait
