#!/bin/bash
# Script para Deployment de Sistemas operativos Debian. Coded By ChuxMan. 22-04-2014
# Parte de la receta del fichero /usr/bin/raspi-config de los MagicBox.
# Copyright © 2014 By Peke Soft, Ltd. Madrid. All Rights Reserved."
Version="1.0.0"
Fecha="NOV 2K14"
About="Peke Soft Snoopix Deployer. v$Version ($Fecha).\nCopyright © 2014 By Peke Soft, Ltd. https://www.pekesoft.com"

# FUNCIÓN PARA COLOREAR EL SHELL DE LA CONSOLA Y ACTIVAR LOS ALIAS.
cp ./files/.bashrc /root/.bashrc
sh ./alias.sh
