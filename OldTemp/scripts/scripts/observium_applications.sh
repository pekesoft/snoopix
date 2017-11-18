#!/bin/bash
# Script para Deployment de Sistemas operativos Debian. Coded By ChuxMan. 06-12-2014
# Parte de la receta de http://www.observium.org/wiki/Debian_Ubuntu_Installation
# Parte de la receta del fichero /usr/bin/raspi-config de los MagicBox.
# Copyright � 2014 By Peke Soft, Ltd. Madrid. All Rights Reserved."

#Incluimos el sistema b�sico de Akira.
dir="${BASH_SOURCE%/*}"
if [[ ! -d "$dir" ]]; then dir="$PWD"; fi
source $dir/akira.sh

#Script para agregar la funcionalidad de monitorizaci�n de monitores
#en equipos cliente, para Observium.
#doObserviumApplication(){

	#Instalaci�n de dependencias.
	apt-get install xinetd
	
	#Copiamos el fichero de configuraci�n del equipo cliente
	cp $dir/../packages/observium/observium_agent_xinetd /etc/xinetd.d/observium_agent
	
	#Copiamos el script agente del equipo cliente
	cp $dir/../packages/observium/observium_agent /usr/bin/observium_agent
	
	#Creamos directorios para contener los scripts clientes.
	mkdir /usr/lib/observium_agent
	mkdir /usr/lib/observium_agent/local
	
	#TODO: Marcamos como ejecutables
	
	#TEMPORAL: Copiamos los scripts aplicacionales.
	cp $dir/../packages/observium/agent-local/* /usr/lib/observium_agent/local
	
#}