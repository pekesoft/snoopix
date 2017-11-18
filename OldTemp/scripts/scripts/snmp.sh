#!/bin/bash
# Script para Deployment de Sistemas operativos Debian. Coded By ChuxMan. 01-12-2014
# Parte de la receta de http://www.observium.org/wiki/NetSNMPd_Client_Configuration
# Parte de la receta para MAC: http://support.apple.com/kb/TA20884?viewlocale=en_US
# Parte de la receta del fichero /usr/bin/raspi-config de los MagicBox.
# Copyright © 2014 By Peke Soft, Ltd. Madrid. All Rights Reserved."

#Incluimos el sistema básico de Akira.
dir="${BASH_SOURCE%/*}"
if [[ ! -d "$dir" ]]; then dir="$PWD"; fi
source $dir/akira.sh

#Script de instalación y activación de SNMP para monitorización.
doMonit(){

#El nombre del canal lo sacamos del fichero hostname.
	CommunityFile=$(</etc/snoopix/snmp/community)

#El nombre del canal lo sacamos del fichero hostname.
	Community=$(whiptail --title "Monitorización de Servidores" --inputbox "Bienvenido a las utilidades de mantenimiento de Jin Radio.\n\nPor favor, especifica un nombre del Canal" 20 70 "Jin Radio $CommunityFile Channel" --cancel-button Cancelar --ok-button Aceptar 3>&1 1>&2 2>&3)

	apt-get install snmpd

	# SNMPDOPTS='-Lsd -Lf /dev/null -u snmp -p /var/run/snmpd.pid'

com2sec readonly  default         $Community
group MyROGroup v1         readonly
group MyROGroup v2c        readonly
group MyROGroup usm        readonly
view all    included  .1                               80
access MyROGroup ""      any       noauth    exact  all    none   none
syslocation $Location
syscontact $Contact
#This line allows Observium to detect the host OS if the distro script is installed
extend .1.3.6.1.4.1.2021.7890.1 distro /usr/bin/distro 

wget http://www.observium.org/svn/observer/trunk/scripts/distro
mv distro /usr/bin/distro
chmod 755 /usr/bin/distro

/etc/init.d/snmpd restart 

	#Grabamos las variables para futuros mantenimientos.

}
