#!/bin/bash
# Script para Deployment de Sistemas operativos Debian. Coded By ChuxMan. 06-12-2014
# Parte de la receta de http://www.observium.org/wiki/Application/MySQL
# Parte de la receta del fichero /usr/bin/raspi-config de los MagicBox.
# Copyright © 2014 By Peke Soft, Ltd. Madrid. All Rights Reserved."

#Incluimos el sistema básico de Akira.
dir="${BASH_SOURCE%/*}"
if [[ ! -d "$dir" ]]; then dir="$PWD"; fi
source $dir/akira.sh

doObserviumMySQL(){

# First you need to create database user with appropriate privileges:

mysql -u root -p
<mysql root password>
mysql> GRANT SUPER, REPLICATION SLAVE, PROCESS ON *.* TO 'observium_mon'@'localhost'
    -> IDENTIFIED BY '<observium_mon password>';

# Copy the mysql script from scripts/agent-local/ in your observium install to /usr/lib/observium_agent/local/ on the server you wish to monitor.

#In the same directory on the monitored server, create config file named mysql.cnf containing previously created credentails:

<?php
$mysql_user = 'observium_mon';
$mysql_pass = '<observium_mon password>';
?>

#The application should now be automatically detected on the next poller run of Observium. You can check that the script works by running it directly, or by running the Agent and checking for the <<<mysql>>> section.

#Note: on Debian based systems, you can just copy in the mysql.cnf file distributed with Observium, without having to create an extra user. The script will then automatically use the Debian system maintenance mysql user.

}