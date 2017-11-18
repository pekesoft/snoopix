#!/bin/bash
# Script para Deployment de Sistemas operativos Debian. Coded By ChuxMan. 06-12-2014
# Parte de la receta de http://www.observium.org/wiki/Application/Shoutcast
# Parte de la receta del fichero /usr/bin/raspi-config de los MagicBox.
# Copyright © 2014 By Peke Soft, Ltd. Madrid. All Rights Reserved."

#Incluimos el sistema básico de Akira.
dir="${BASH_SOURCE%/*}"
if [[ ! -d "$dir" ]]; then dir="$PWD"; fi
source $dir/akira.sh

doObservium_Shoutcast() {

#First you need to edit the shoutcast agent script and change the settings:

# // START SETTINGS ///
 
 $config         = "/usr/lib/observium_agent/local/shoutcast.conf";
 $cache          = "/tmp/observium-agent-shoutcast";
 
# // END SETTINGS ///

#Then you need to edit your shoutcast.conf file:

 # hostname:port
 server1.domain.tld:8000
 server1.domain.tld:9345

#And for the last part you need to setup a crontab that calls the shoutcast agent script every 5 minutes:

 */5 * * * * root /usr/lib/observium_agent/local/shoutcast makeCache

}