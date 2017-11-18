#!/bin/bash
# Script para Deployment de Sistemas operativos Debian. Coded By ChuxMan. 01-12-2014
# Parte de la receta de http://askubuntu.com/questions/84483/how-to-completely-uninstall-java
# Parte de la receta del fichero /usr/bin/raspi-config de los MagicBox.
# Copyright © 2014 By Peke Soft, Ltd. Madrid. All Rights Reserved."

#Incluimos el sistema básico de Akira.
dir="${BASH_SOURCE%/*}"
if [[ ! -d "$dir" ]]; then dir="$PWD"; fi
source $dir/akira.sh

#Script para la completa eliminación de Java.

#Actualización de las bases de datos de los repositorios.
apt-get update

#Búsqueda de elementos de Java.
apt-cache search java | awk '{print($1)}' | grep -E -e '^(ia32-)?(sun|oracle)-java' -e '^openjdk-' -e '^icedtea' -e '^(default|gcj)-j(re|dk)' -e '^gcj-(.*)-j(re|dk)' -e 'java-common' | xargs apt-get -y remove

#Autoeliminación de Huérfanos.
apt-get -y autoremove

#Eliminación de ficheros de configuración.
dpkg -l | grep ^rc | awk '{print($2)}' | xargs apt-get -y purge

#Eliminación de directorios de caché y configuración.
bash -c 'ls -d /home/*/.java' | xargs rm -rf

#Eliminación de JVMs manuales.
rm -rf /usr/lib/jvm/*

#Eliminar entradas de Java si siguen existiendo, y sus alternativas.
for g in ControlPanel java java_vm javaws jcontrol jexec keytool mozilla-javaplugin.so orbd pack200 policytool rmid rmiregistry servertool tnameserv unpack200 appletviewer apt extcheck HtmlConverter idlj jar jarsigner javac javadoc javah javap jconsole jdb jhat jinfo jmap jps jrunscript jsadebugd jstack jstat jstatd native2ascii rmic schemagen serialver wsgen wsimport xjc xulrunner-1.9-javaplugin.so; update-alternatives --remove-all $g; done

#Búsqueda de posibles elementos restantes.
updatedb
locate -b '\pack200'

echo "Si el comando anterior devolvió resultados, eliminar la carpeta con rm -rf /ruta/a/jre1.x.x_xx"
