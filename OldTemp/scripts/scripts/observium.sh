#!/bin/bash
# Script para Deployment de Sistemas operativos Debian. Coded By ChuxMan. 06-12-2014
# Parte de la receta de http://www.observium.org/wiki/Debian_Ubuntu_Installation
# Parte de la receta del fichero /usr/bin/raspi-config de los MagicBox.
# Copyright © 2014 By Peke Soft, Ltd. Madrid. All Rights Reserved."

#Incluimos el sistema básico de Akira.
dir="${BASH_SOURCE%/*}"
if [[ ! -d "$dir" ]]; then dir="$PWD"; fi
source $dir/akira.sh

doObservium(){

apt-get install libapache2-mod-php5 php5-cli php5-mysql php5-gd php5-snmp php-pear snmp graphviz php5-mcrypt php5-json \
subversion mysql-server mysql-client rrdtool fping imagemagick whois mtr-tiny nmap ipmitool python-mysqldb libvirt-bin -y

mkdir -p /opt/observium && cd /opt

wget http://www.observium.org/observium-community-latest.tar.gz
tar zxvf observium-community-latest.tar.gz

cd observium

cp config.php.default config.php

# TODO: VirtualHost & Descover/Polling
}

doDiscovery(){

/discovery.php -h all
}

doPoller(){

/opt/observium/poller.php -h all

}
