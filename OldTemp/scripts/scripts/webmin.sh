#!/bin/bash
# Script para Deployment de Sistemas operativos Debian. Coded By ChuxMan. 22-04-2014
# Parte de la receta del fichero /usr/bin/raspi-config de los MagicBox.
# Copyright © 2014 By Peke Soft, Ltd. Madrid. All Rights Reserved."
Version="1.0.0"
Fecha="NOV 2K14"
About="Peke Soft Snoopix Deployer. v$Version ($Fecha).\nCopyright © 2014 By Peke Soft, Ltd. https://www.pekesoft.com"

# FUNCIÓN DE INSTALACIÓN DE WEBMIN.
# doWebmin() {
	# Para instalar Webmin en ubuntu server 12.04 LTS tenemos dos metodos diferentes, 
	# el primero es usando APT y el segundo hacerlo de forma manual.
	# Pero antes de instalar Webmin es necesario tener instaladas algunas bibliotecas
 	# Perl que webmin usa para funcionar, por eso vamos a instalarlas primero.

	# Empecemos:

	apt-get install perl libnet-ssleay-perl libauthen-pam-perl libpam-runtime openssl libio-pty-perl apt-show-versions python -y

	# Ahora vamos a ver los dos metodos que podemos usar para instalar Webmin.

	# Metodo 1: Instalación de Webmin via APT.

	# sudo -i

	# Añadimos el repositori de  Webmin al servidor Ubuntu con el siguiente comando:

	cat >> /etc/apt/sources.list <<-EOF
	deb http://download.webmin.com/download/repository sarge contrib
	deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib
	EOF

	# Salimos de root:
	# exit

	# Importamos la GPG key, actualizamos el repositorio y luego instalamos webmin

	wget http://www.webmin.com/jcameron-key.asc && sudo apt-key add jcameron-key.asc

	apt-get update
	apt-get install webmin -y

	# Metodo 2: Instalar Webmin de forma Manual.
	# Descargamos el archivo de la ultima version de webmin eligiendo los paquetes debian.
	# wget http://www.webmin.com/download/deb/webmin-masactual.deb
	# Instalamos Webmin con el siguiente comando:
	# sudo dpkg --install webmin-masactual.deb
	
	# Ya hemos terminado.
	# Ahora para arrancar webmin:  http://tuserver:10000/
