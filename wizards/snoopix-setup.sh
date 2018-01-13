#!/bin/bash

#----------------------------------------------------------------------
# Script para la instalación y mantenimiento del propio Snoopix.
#----------------------------------------------------------------------
# Copyright © 2018 by Peke Soft, Ltd. JAN-2018.
#----------------------------------------------------------------------

#Comprobamos el Sistema Operativo y su versión.
#TODO

#Comprobamos la existencia de GIT.
echo "Introduce el nombre del paquete"
read miprograma
RESPUESTA=$(dpkg --get-selections | grep -w ${miprograma} | grep -w install)
if [ "$RESPUESTA" = "" ]; then
    echo "NO ESTA INSTALADO"
    apt -y install ${miprograma}
else
    echo "${miprograma} YA ESTA INSTALADO"
fi
