#!/bin/bash
# Script para Deployment de Sistemas operativos hacia Snoopix. Coded By ChuxMan. 22-04-2014
# Archivo de definiciones básicas comunes a todos los scripts.
# Parte de la receta del fichero /usr/bin/raspi-config de los MagicBox.
# Copyright © 2014 By Peke Soft, Ltd. Madrid. All Rights Reserved."

# Para incluir el sistema básico de Akira en otros scripts.
# Parte de la receta de http://stackoverflow.com/questions/192292/bash-how-best-to-include-other-scripts
# dir="${BASH_SOURCE%/*}"
# if [[ ! -d "$dir" ]]; then dir="$PWD"; fi
# source $dir/akira.sh

# Más info:
# BASH: http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-8.html
#		http://www.tutorialspoint.com/unix/unix-shell-functions.htm
# OS:	http://stackoverflow.com/questions/394230/detect-the-os-from-a-bash-script
# XML:	http://unix.stackexchange.com/questions/83385/parse-xml-to-get-node-value-in-bash-script


#Variables del Sistema.
Version="1.1.0"
Fecha="DEC 2K14"
About="Peke Soft Snoopix Deployer. v$Version ($Fecha). - http://www.snoopix.org\nCopyright © 2011-2014 By Peke Soft, Ltd. - https://www.pekesoft.com"


#Función original de raspi-config, de donde he extraído parte de la mecánica de menús,
#para calcular tamaños de ventana.
calc_wt_size() {
  # NOTE: it's tempting to redirect stderr to /dev/null, so supress error 
  # output from tput. However in this case, tput detects neither stdout or 
  # stderr is a tty and so only gives default 80, 24 values
  WT_HEIGHT=17
  WT_WIDTH=$(tput cols)

  if [ -z "$WT_WIDTH" ] || [ "$WT_WIDTH" -lt 60 ]; then
    WT_WIDTH=80
  fi
  if [ "$WT_WIDTH" -gt 178 ]; then
    WT_WIDTH=120
  fi
  WT_MENU_HEIGHT=$(($WT_HEIGHT-8))
}

# FUNCIÓN DE ACERCA DE
doAbout() {
whiptail --title "Jin Radio Channel Tools" --msgbox "\
Esta herramienta realiza la creación y el mantenimiento de un canal de Jin Radio, la instalación del Airtime, copias regulares de la base de datos y la exportación a la nube de Peke Soft, así como su mantenimiento completo, incluyendo la restauración y limpieza. Esta herramienta crea además comandos de shell y otra serie de utilidades de interés.

$About

Soporte         http://support.pekesoft.com
Ayuda Usuario:  http://www.jinradio.com/ayuda
Producto:       https://www.pekesoft.com/products/jrct
Contacto:       mailto:info@jinradio.com\
" 22 70 1
}