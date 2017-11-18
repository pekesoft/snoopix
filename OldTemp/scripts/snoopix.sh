#!/bin/bash
# Script para Deployment de Sistemas operativos Debian. Coded By ChuxMan. 22-04-2014
# Parte de la receta del fichero /usr/bin/raspi-config de los MagicBox.
# Copyright © 2014 By Peke Soft, Ltd. Madrid. All Rights Reserved."
Version="1.0.0"
Fecha="NOV 2K14"
About="Peke Soft Snoopix Deployer. v$Version ($Fecha).\nCopyright © 2014 By Peke Soft, Ltd. https://www.pekesoft.com"

## CONJUNTO DE FUNCIONES ESPECÍFICAS DE ESTE SCRIPT. ##

# Función para crear alias MSDOS de funcionalidades standard 
doAliases() {
	#Creamos los alias MSDOS básicos.
	
	#DIR
	echo 'alias dir="ls -la"' >> ~/.bashrc && . ~/.bashrc 

	#MD
	echo 'alias md="mkdir"' >> ~/.bashrc && . ~/.bashrc 

	#CD..
	echo 'alias cd..="cd .."' >> ~/.bashrc && . ~/.bashrc 

	#DEL
	echo 'alias del="rm"' >> ~/.bashrc && . ~/.bashrc 

	#DELTREE
	echo 'alias deltree="rm -R"' >> ~/.bashrc && . ~/.bashrc 
}

#Función para eliminar paquetes innecesarios en un servidor básico
doServer() {

	#Elementos a eliminar de los MagicBox basados en Raspberry Pi y Raspbian.

	#Elementos a eliminar de los MagicBox basados en Odroid.

	#Elementos a eliminar de los MagicBox basados en Ubuntu/Intel NUC.

}

#Función para instalar TeamViewer.
doTeamViewer() {

}

#Funcion para instalar Chrome.
doChrome() {

}

#Función para instalar la virtualización de Virtual Box.
doVirtualBox() {

}

#Función para instalar las extensiones de Virtual Box en los servidores virtualizados
doVirtual() {

}

#Función para crear las Imágenes de arranque de las diferentes ediciones de Snoopix.
doStart() {

}

#Función para instalar un servidor de Subversion
doSVN() {
	#Instalamos los componentes del Subversion.
	sudo apt-get install subversion subversion-tools -y
}

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

# FUNCIÓN DE BIENVENIDA PARA PRIMERA INSTALACIÓN.
doWelcome() {
whiptail --title "Jin Radio Channel Tools" --msgbox "\
Bienvenido a Jin Radio Channel Tools. v$Version ($Fecha).

Esta herramienta realiza la creación y el mantenimiento de un canal de Jin Radio, la instalación del Airtime, copias regulares de la base de datos y la exportación a la nube de Peke Soft, así como su mantenimiento completo, incluyendo la restauración y limpieza. Esta herramienta crea además comandos de shell y otra serie de utilidades de interés.

A continuación se procederá a instalar este script y configurar básicamente los preliminares del canal.\
" 20 70 1
}

# FUNCIÓN DE SALIDA
doFinish() {
	clear
	exit 0
}

# FUNCIÓN DE LECTURA DEL CANAL
readChannel() {


	#Comprobamos que exista una carpeta para los archivos del Jin Radio.
	if [ ! -d /etc/jinradio ]; then
		doBasics
	fi

	#Comprobamos a ver si existe ya un fichero con el nombre del canal.
	if [ -f /etc/jinradio/channel ]; then
		echo "b"
	fi
}


# FUNCIÓN DE CONFIGURACIÓN BÁSICA: Se ejecuta sólo una vez cuando se llama a esta
# utilidad por primera vez, y podrá ser editado a través del menú principal.
doBasics() {
	date +"[%x %X] Iniciando Jin Radio Channel Tools por primera vez..."

	#Mostramos una pantalla de presentación para los usuarios.
	doWelcome

	#El nombre del canal lo sacamos del fichero hostname.
	Canal=$(</etc/hostname)

	#Creamos el conjunto de carpetas básicas para canal
	#sudo mkdir /etc/jinradio.com

	Canal=$(whiptail --title "Jin Radio Channel Tools" --inputbox "Bienvenido a las utilidades de mantenimiento de Jin Radio.\n\nPor favor, especifica un nombre del Canal" 20 70 "Jin Radio $Canal Channel" --cancel-button Cancelar --ok-button Aceptar 3>&1 1>&2 2>&3)
}

# FUNCIÓN DE DESCARGA DEL AIRTIME
doDownload() {
	date +"[%x %X] Instalando componentes previos y descargando Airtime..."
	sudo apt-get install gdebi -y
	cd /home/jinradio/Descargas
	mkdir Airtime
	cd Airtime
	wget http://apt.sourcefabric.org/misc/airtime-easy-setup.deb


	date +"[%x %X] Preinstalando Airtime..."
	sudo gdebi airtime-easy-setup.deb
}

# FUNCIÓN DE ACTUALIZACIÓN DEL REPOSITORIO DEL AIRTIME
doRepository() {
	#Comprobamos parámetros, y si no hay ponemos versión por defecto wheezy
	MyVer="wheezy"

	if [ $# -gt 0 ]; then
		MyVer="$1"
	fi

	date +"[%x %X] Actualizando repositorios de Airtime..."
	../Plantillas/sourcefabric.list.sh "$MyVer" > ../Plantillas/sourcefabric.list

	sudo cp ../Plantillas/sourcefabric.list /etc/apt/sources.list.d/ -f
}

# FUNCIÓN DE INSTALACIÓN DEL AIRTIME
doSetup() {
	# Script para actualizar los repositorios del Airtime, incompatible por el momento con la versión 14.04. Coded By ChuxMan. 22-04-2014

	# Después nos pedirá instalar el paquete airtime:
	date +"[%x %X] Actualizando el sistema..."
	sudo apt-get update -y

	date +"[%x %X] Instalando Airtime..."
	sudo apt-get install airtime -y

	# Después nos metemos en la IP de nuestro servidor y como usuario ponemos admin y como contraseña: admin. Después configuraremos Airtime a nuestro antojo.
	# Cuando vayamos a pasar a producción, ejecutamos:
	# sudo dpkg-reconfigure airtime
}

# FUNCIÓN DE ACTUALIZACIÓN DE LA PLANTILLA DE APACHE DEL AIRTIME
doApache() {
	# Script para arreglar un script incompatible del airtime con la nueva versión de apache.
	# Coded By ChuxMan. 23-04-2014

	date +"[%x %X] Arreglando incompatibilidades con Apache..."
	sudo cat <<- EOF > /etc/airtime/apache.vhost.tpl
		<VirtualHost *:80>
			  ServerName __SERVER_NAME__
			  #ServerAlias www.example.com

			  ServerAdmin __SERVER_ADMIN__

			  DocumentRoot /usr/share/airtime/public
			  DirectoryIndex index.php

			  SetEnv APPLICATION_ENV "production"

			  <Directory /usr/share/airtime/public>
				      Options -Indexes +FollowSymLinks +MultiViews
				      AllowOverride All
				      Order allow,deny
				      Allow from all
			  </Directory>
		</VirtualHost> 
	EOF

	# Reinstalando con Compatibilidad con apache.
	date +"[%x %X] Reinstalando Airtime..."
	sudo apt-get install airtime -y
}

# FUNCIÓN PARA HABILITAR SUBIDAS WEB DEL AIRTIME
doUploads() {
	# Script para habilitar la subida de ficheros en el airtime en Ubuntu 14.04.
	# Coded By ChuxMan. 23-04-2014

	# Este script soluciona un problema de airtime, que permitía la subida de ficheros,
	# pero luego no quedaba ni rastro de ellos en las carpetas ni en la biblioteca.
	# Consultar incidencia #67.

	date +"[%x %X] Habilitando subida de ficheros en Airtime para Ubuntu 12.10 o superior..."
	sudo cp /etc/airtime/airtime.ini /etc/php5/apache2/conf.d -f
}

# FUNCIÓN PARA HABILITAR SERVIDOR Y SERVICIO DE FTP
doFTP() {
b
}

# FUNCIÓN PARA COMPILAR LIQUIDSOAP CON COMPATIBILIDAD AAC+
# Y ACTUALIZAR AIRTIME PARA SU SOPORTE
doAAC() {
	# Compiling Liquidsoap
	# Preparation for compiling with AAC+
	# You will need to download and compile a package first. This is very
	# simple, and step-by-step instructions will be provided here.

	# Before we start, you will need some packages. From the terminal, type
	sudo apt-get install build-essential -y
	 
	# The next step is to download the latest version of fdk-aac here. At the time of this writing, the version is 0.1.1.
	# Once downloaded, extract the tar ball. From the terminal, type

	# http://sourceforge.net/projects/opencore-amr/files/latest/download?source=files

	tar xzf fdk-aac-0.1.1.tar.gz

	# Now cd into the newly created directory
	cd fdk-aac-0.1.1

	# Now enter the following commands:
	./configure --prefix /usr
	make
	sudo make install

	## COMPILAMOS LIQUIDSOAP
	makeLiquidsoap

	# Now that we have the appropriate packages installed, the next step is to build
	# Liquidsoap with AAC+ enabled. Detailed compilation and installation instructions
	# are available here: Building Liquidsoap from Source
	 
	# Enabling AAC+ in the Airtime UI
	# Now that Liquidsoap has been compiled with AAC+ support, we have one more final
	# step - enable the ability to select these output types in the Web UI.
	#To enable AAC+ run the following:
	sudo -u postgres psql -c "update cc_pref set valstr = valstr||', fdkaac' where keystr = 'stream_type'" airtime
	 
	# To revert the above command, simply run:
	# sudo -u postgres psql -c "update cc_pref set valstr = 'ogg, mp3, opus, aac' where keystr = 'stream_type'" airtime
	 
	# Your Airtime install should now fully support AAC+ output.  
}

# FUNCIÓN DE COMPILACIÓN DE LIQUIDSOAP.
makeLiquidsoap() {
	# Compilation
	# On Ubuntu 10.04 or newer install the following packages:
	sudo apt-get -y --force-yes install git-core ocaml-findlib libao-ocaml-dev \
	libportaudio-ocaml-dev libmad-ocaml-dev libtaglib-ocaml-dev libalsa-ocaml-dev \
	libvorbis-ocaml-dev libladspa-ocaml-dev libxmlplaylist-ocaml-dev libflac-dev \
	libxml-dom-perl libxml-dom-xpath-perl patch autoconf libmp3lame-dev \
	libcamomile-ocaml-dev libcamlimages-ocaml-dev libtool libpulse-dev camlidl \
	libfaad-dev libpcre-ocaml-dev 
	 
	#backported opus 1.0+ packages from apt.sourcefabric.org
	sudo apt-get install libopus-dev -y
	 
	#add festival dev packages for say: protocol support
	sudo apt-get install festival-dev -y
	  
	#AAC encoder - only for Ubuntu versions 11.10 and up
	sudo apt-get install libvo-aacenc-dev -y
	 
	rm -rf liquidsoap-full
	git clone https://github.com/savonet/liquidsoap-full
	cd liquidsoap-full
	make init
	make update
	 
	cp PACKAGES.minimal PACKAGES
	 
	sed -i "s/#ocaml-portaudio/ocaml-portaudio/g" PACKAGES
	sed -i "s/#ocaml-alsa/ocaml-alsa/g" PACKAGES
	sed -i "s/#ocaml-pulseaudio/ocaml-pulseaudio/g" PACKAGES
	sed -i "s/#ocaml-faad/ocaml-faad/g" PACKAGES
	 
	#Also enable ocaml-opus after installing backported dev packages
	sed -i "s/#ocaml-opus/ocaml-opus/g" PACKAGES
	 
	#ocaml-voaacenc is not available on Lucid
	sed -i "s/#ocaml-voaacenc/ocaml-voaacenc/g" PACKAGES
	 
	#AAC+ support full instructions here: https://wiki.sourcefabric.org/x/NgPQ
	#Remove the hash '#' symbol from the following line to enable AAC+
	sed -i "s/#ocaml-fdkaac/ocaml-fdkaac/g" PACKAGES 
	 
	./bootstrap
	./configure
	make

	# Create source package
	cd..
	cp -r liquidsoap-full/ /tmp/
	cd /tmp/liquidsoap-full/
	rm -rf .git .gitignore .gitmodules
	cd ..
	tar -czf liquidsoap-1.1.1.tar.gz liquidsoap-full/

	# Installation
	# The compiled liquidsoap binary will now be present in liquidsoap-full/liquidsoap/src

	# On Airtime 2.3 and lower, run 
	# sudo service airtime-liquidsoap stop
	# sudo cp liquidsoap-full/liquidsoap/src/liquidsoap /usr/bin/liquidsoap
	# sudo service airtime-liquidsoap start 

	# On Airtime 2.4 and higher, run
	sudo service airtime-liquidsoap stop-with-monit
	sudo cp liquidsoap-full/liquidsoap/src/liquidsoap /usr/bin/liquidsoap
	sudo service airtime-liquidsoap start-with-monit 
	
	# Your new Liquidsoap installation is now done!
	# Testing
	# To test Icecast:
	# cd liquidsoap/src
	# ./liquidsoap 'output.icecast(%vorbis, mount="test.ogg", sine())'
	# mplayer http://localhost:8000/test.ogg
	# To test direct soundcard output:
	# cd liquidsoap/src
	# ./liquidsoap 'output.ao(sine())'
	# In both of the options above, you should hear a constant buzzing noise that is generated by the input sine wave.
}

# FUNCIÓN DE INSTALACIÓN DE WEBMIN.
doWebmin() {
	# Para instalar Webmin en ubuntu server 12.04 LTS tenemos dos metodos diferentes, 
	# el primero es usando APT y el segundo hacerlo de forma manual.
	# Pero antes de instalar Webmin es necesario tener instaladas algunas bibliotecas
 	# Perl que webmin usa para funcionar, por eso vamos a instalarlas primero.

	# Empecemos:

	sudo apt-get install perl libnet-ssleay-perl libauthen-pam-perl libpam-runtime openssl libio-pty-perl apt-show-versions python -y

	# Ahora vamos a ver los dos metodos que podemos usar para instalar Webmin.

	# Metodo 1: Instalación de Webmin via APT.

	# sudo -i

	# Añadimos el repositori de  Webmin al servidor Ubuntu con el siguiente comando:

	sudo cat >> /etc/apt/sources.list <<-EOF
	deb http://download.webmin.com/download/repository sarge contrib
	deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib
	EOF

	# Salimos de root:
	# exit

	# Importamos la GPG key, actualizamos el repositorio y luego instalamos webmin

	wget http://www.webmin.com/jcameron-key.asc && sudo apt-key add jcameron-key.asc

	sudo apt-get update
	sudo apt-get install webmin -y

	# Metodo 2: Instalar Webmin de forma Manual.
	# Descargamos el archivo de la ultima version de webmin eligiendo los paquetes debian.
	# wget http://www.webmin.com/download/deb/webmin-masactual.deb
	# Instalamos Webmin con el siguiente comando:
	# sudo dpkg --install webmin-masactual.deb
	
	# Ya hemos terminado.
	# Ahora para arrancar webmin:  http://tuserver:10000/
}


# FUNCIÓN PARA INSTALAR PHPPGADMIN
doPhpPgAdmin() {
b
}

# FUNCIÓN PARA INSTALAR APPS DE USO GENERAL
doApps() {
a
}

# FUNCIÓN PARA HABILITAR LA ADMINISTRACIÓN SSH
doSSH() {
b
}

# FUNCIÓN PARA MONITORIZAR TODOS LOS SERVICIOS DEL AIRTIME.
doMonitor() {
b
}

#######
# FUNCIÓN DE ACTUALIZACIÓN DEL REPOSITORIO DEL AIRTIME
doUploadsa() {
a
}

# FUNCIÓN DE ACTUALIZACIÓN DEL REPOSITORIO DEL AIRTIME
doRepository3b() {
b
}

# FUNCIÓN DE SERVICIOS ADICIONALES
doServices() {
  FUN=$(whiptail --title "Jin Radio Channel Tools" --menu "[Jin Radio $Canal Channel] Instalación de servicios adicionales del servidor" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Volver --ok-button Seleccionar \
    "S1 Instalar Webmin" "Monitorización completa del servidor via Web" \
    "S2 Instalar phpPgAdmin" "Gestor de la base de datos del Airtime (PostgreSQL)" \
    "S3 Descargar Apps de Cliente" "Descarga Google Chrome, TeamViewer, etc" \
    "S4 Habilitar SSH" "Habilita la administración remota mediante SSH" \
    3>&1 1>&2 2>&3)
  RET=$?
  if [ $RET -eq 1 ]; then
    return 0
  elif [ $RET -eq 0 ]; then
    case "$FUN" in
      S1\ *) doWebmin ;;
      S2\ *) doPhpPgAdmin ;;
      S3\ *) doApps ;;
      S4\ *) doSSH ;;
     *) whiptail --msgbox "Error de programación, opción no reconocida." 20 60 1 ;;
    esac || whiptail --msgbox "Hubo algún error mientras se ejecutaba $FUN" 20 60 1
  fi
}

# FUNCIÓN DE INSTALACIÓN DEL AIRTIME
doInstall() {
  FUN=$(whiptail --title "Jin Radio Channel Tools" --menu "[Jin Radio $Canal Channel] Instalación y mantenimiento del Airtime" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Volver --ok-button Seleccionar \
    "A1 Descargar y Preinstalar" "Archivos previos y motor del Airtime" \
    "A2 Repositorio Compatible" "Para S.O. nuevos sin soporte" \
    "A3 Instalar" "Instala Airtime y complementos" \
    "A4 Compatibilidad Apache" "Para Ubuntu 12.10 o superior actualiza plantillas" \
    "A5 Habilitar Uploads" "Habilita la subida de ficheros a través de la Web" \
    "A6 Habilitar FTP" "Crea servidor FTP y servicios de monitorización diarios" \
    "A7 Compilar Liquidsoap con AAC+" "Compila una nueva versión con soporte AAC+" \
    3>&1 1>&2 2>&3)
  RET=$?
  if [ $RET -eq 1 ]; then
    return 0
  elif [ $RET -eq 0 ]; then
    case "$FUN" in
      A1\ *) doDownload ;;
      A2\ *) doRepository ;;
      A3\ *) doSetup ;;
      A4\ *) doApache ;;
      A5\ *) doUploads ;;
      A6\ *) doFTP ;;
      A7\ *) doAAC ;;
     *) whiptail --msgbox "Error de programación, opción no reconocida." 20 60 1 ;;
    esac || whiptail --msgbox "Hubo algún error mientras se ejecutaba $FUN" 20 60 1
  fi
}

# FUNCIÓN DE BACKUP DEL AIRTIME
doBackup() {
  FUN=$(whiptail --title "Jin Radio Channel Tools" --menu "[Jin Radio $Canal Channel] Backup y Restauración de la base de datos del Airtime" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Volver --ok-button Seleccionar \
    "B1 Backup diario, semanal y mensual" "Crea scripts programados en cron" \
    "B2 Hostname" "Set the visible name for this Pi on a network" \
    "B3 Memory Split" "Change the amount of memory made available to the GPU" \
    "B4 SSH" "Enable/Disable remote command line access to your Pi using SSH" \
    "A5 SPI" "Enable/Disable automatic loading of SPI kernel module (needed for e.g. PiFace)" \
    "A6 Audio" "Force audio out through HDMI or 3.5mm jack" \
    "A7 Update" "Update this tool to the latest version" \
    3>&1 1>&2 2>&3)
  RET=$?
  if [ $RET -eq 1 ]; then
    return 0
  elif [ $RET -eq 0 ]; then
    case "$FUN" in
      B1\ *) doDownload ;;
      B2\ *) do_change_hostname ;;
      B3\ *) do_memory_split ;;
      B4\ *) do_ssh ;;
      A5\ *) do_spi ;;
      A6\ *) do_audio ;;
      A7\ *) do_update ;;
      *) whiptail --msgbox "Error de programación, opción no reconocida." 20 60 1 ;;
    esac || whiptail --msgbox "Hubo algún error mientras se ejecutaba $FUN" 20 60 1
  fi
}

# MENÚ PRINCIPAL
calc_wt_size

# Iniciando Script...
echo "$About\n"

#Leemos el canal y las variables básicas.
readChannel

while true; do

Accion=$(whiptail --title "Jin Radio Channel Tools" --menu "Instalación y Mantenimiento de Jin Radio $Canal Channel" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Salir --ok-button Seleccionar \
    "1 Configuración Básica" "Nombre del Canal y aspectos básicos" \
    "2 Instalación del Airtime" "Descarga, instala y configura" \
    "3 Copia de Seguridad" "Mantenimiento automático y Restauración de Backup" \
    "4 Servicios Adicionales" "Instalación de complementos del servidor" \
    "5 Monitores" "Comprueba los estados de los servicios del Airtime" \
    "6 Acerca de Jin Radio Channel Tools" "Información y ayuda de esta utilidad" \
    3>&1 1>&2 2>&3)
  RET=$?
  if [ $RET -eq 1 ]; then
    doFinish
  elif [ $RET -eq 0 ]; then
    case "$Accion" in
      1\ *) doBasics ;;
      2\ *) doInstall ;;
      3\ *) doBackup ;;
      4\ *) doServices ;;
      5\ *) doMonitor ;;
      6\ *) doAbout ;;
      *) whiptail --msgbox "Error de programación, opción no reconocida." 20 60 1 ;;
    esac || whiptail --msgbox "Hubo algún error mientras se ejecutaba $FUN" 20 60 1
  else
    exit 1
  fi
done

exit
