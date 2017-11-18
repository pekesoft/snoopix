#!/bin/bash
# Script para la limpieza de Sistemas operativos Debian. Coded By ChuxMan. 26-12-2014
# Copyright © 2014 By Peke Soft, Ltd. Madrid. All Rights Reserved."

#Incluimos el sistema básico de Akira.
dir="${BASH_SOURCE%/*}"
if [[ ! -d "$dir" ]]; then dir="$PWD"; fi
source $dir/akira.sh

doCleanUp(){
	
	# Nos cepillamos el LibreOffice (Ubuntu lo mete de serie)
	sudo apt-get remove -y libreoffice-impress libreoffice-l10n-es libreoffice-math libreoffice-ogltrans libreoffice-pdfimport libreoffice-style-human libreoffice-writer libreoffice-avmedia-backend-gstreamer libreoffice-base-core libreoffice-calc libreoffice-common libreoffice-core libreoffice-draw libreoffice-gnome libreoffice-gtk libreoffice-help-en-us libreoffice-help-es
	
	sudo apt-get autoremove -y
	
	#Eliminación de ficheros de usuario de Ubuntu. (Innecesarios para un servidor)
	sudo apt-get remove -y ubuntu-artwork ubuntuone-client-data ubuntu-standard ubuntu-desktop ubuntu-docs ubuntu-touch-sounds ubuntu-drivers-common ubuntu-ui-toolkit-theme ubuntu-wallpapers ubuntu-wallpapers-trusty ubuntu-minimal ubuntu-sounds ubuntu-wallpapers-utopic ubuntu-mobile-icons ubuntu-sso-client ubuntu-mono ubuntu-sso-client-qt
	
	sudo apt-get autoremove -y
	
	#Eliminación de algunos apps
	sudo apt-get remove -y dvd+rw-tools nautilus nautilus-data nautilus-sendto openoffice.org-hyphenation rhythmbox rhythmbox-data rhythmbox-mozilla rhythmbox-plugin-cdrecorder rhythmbox-plugin-magnatune rhythmbox-plugins rhythmbox-plugin-zeitgeist ttf-bitstream-vera ttf-indic-fonts-core ttf-punjabi-fonts ttf-ubuntu-font-family thunderbird thunderbird-gnome-support thunderbird-locale-en thunderbird-locale-en-us thunderbird-locale-es thunderbird-locale-es-es totem totem-common totem-mozilla totem-plugins uno-libs3 usb-creator-common usb-creator-gtk usb-modeswitch usb-modeswitch-data gnome-control-center gnome-settings-daemon
	
	sudo apt-get autoremove -y
    
    #Eliminación del gestor gafico X11 (Xorg)
sudo apt-get remove -y xserver-xorg

sudo apt-get remove -y unity unity-asset-pool unity-greeter unity-gtk2-module unity-gtk3-module unity-gtk-module-common unity-lens-applications unity-lens-files unity-lens-friends unity-lens-music unity-lens-photos unity-lens-video unity-schemas unity-scope-audacious unity-scope-calculator unity-scope-chromiumbookmarks unity-scope-clementine unity-scope-colourlovers unity-scope-devhelp unity-scope-firefoxbookmarks unity-scope-gdrive unity-scope-gmusicbrowser unity-scope-gourmet unity-scope-guayadeque unity-scope-home unity-scope-manpages unity-scope-musicstores unity-scope-musique unity-scope-openclipart unity-scopes-master-default unity-scopes-runner unity-scope-texdoc unity-scope-tomboy unity-scope-video-remote unity-scope-virtualbox unity-scope-yelp unity-scope-zotero unity-services unity-voice-service x11-apps x11-common x11-session-utils x11-utils x11-xfs-utils x11-xkb-utils x11-xserver-utils xbitmaps xcursor-themes xfonts-base xfonts-encodings xfonts-mathml xfonts-scalable xfonts-utils xserver-common xserver-xorg-core xserver-xorg-input-all xserver-xorg-input-evdev xserver-xorg-input-mouse xserver-xorg-input-synaptics xserver-xorg-input-vmmouse xserver-xorg-input-wacom xserver-xorg-video-all xserver-xorg-video-ati xserver-xorg-video-cirrus xserver-xorg-video-fbdev xserver-xorg-video-intel xserver-xorg-video-mach64 xserver-xorg-video-mga xserver-xorg-video-modesetting xserver-xorg-video-neomagic xserver-xorg-video-nouveau xserver-xorg-video-openchrome xserver-xorg-video-qxl xserver-xorg-video-r128 xserver-xorg-video-radeon xserver-xorg-video-s3 xserver-xorg-video-savage xserver-xorg-video-siliconmotion xserver-xorg-video-sisusb xserver-xorg-video-tdfx xserver-xorg-video-trident xserver-xorg-video-vesa xserver-xorg-video-vmware xterm libice6 signon-ui

    sudo apt-get remove -y firefox firefox-locale-en firefox-locale-es fonts-dejavu-core fonts-droid fonts-freefont-ttf fonts-kacst fonts-kacst-one fonts-khmeros-core fonts-lao fonts-liberation fonts-lklug-sinhala fonts-nanum fonts-opensymbol qemu-utils qemu-user-binfmt qemu-user qemu-system-x86 qemu-system-sparc qemu-system-ppc qemu-system-misc qemu-system-mips qemu-system-common qemu-system-arm qemu-system qemu-slof shotwell shotwell-common telepathy-gabble telepathy-haze telepathy-idle telepathy-indicator telepathy-logger telepathy-mission-control-5 telepathy-salut ubuntu-touch-sounds
    
    sudo apt-get autoremove -y

    #Eliminación de los drivers de impresoras para servidores generales.
sudo apt-get remove -y printer-driver-brlaser printer-driver-c2esp printer-driver-foo2zjs printer-driver-foo2zjs-common printer-driver-gutenprint printer-driver-hpcups printer-driver-min12xxw printer-driver-pnm2ppa  printer-driver-postscript-hp printer-driver-ptouch printer-driver-pxljr printer-driver-sag-gdi printer-driver-splix system-config-printer-common system-config-printer-gnome system-config-printer-udev


	#Autolimpieza
	sudo apt-get autoremove -y
	sudo apt-get purge
	sudo apt-get autoclean
	sudo apt-get clean 
	

}
