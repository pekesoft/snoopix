#!/bin/sh

INTERACTIVE=True
ASK_TO_REBOOT=0
BLACKLIST=/etc/modprobe.d/raspi-blacklist.conf
CONFIG=/boot/config.txt

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
  WT_MENU_HEIGHT=$(($WT_HEIGHT-7))
}


#
# Interactive use loop
#
calc_wt_size
while true; do
  FUN=$(whiptail --title "Mantenimiento de Servidores Web - Snoopix" --menu "Servicios Web" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Volver --ok-button Seleccionar \
    "1 Apache" "Servidor robusto, estable y muy popular y extenido" \
    "2 Nginx" "Servidor más liviano y óptimo" \
    "3 Node.js" "Servidor moderno basado en javascript" \
    "4 Varnish" "Caché acelerador de carga" \
    3>&1 1>&2 2>&3)
  RET=$?
  if [ $RET -eq 1 ]; then
    exit 0
  elif [ $RET -eq 0 ]; then
    case "$FUN" in
      1\ *) do_expand_rootfs ;;
      2\ *) do_change_pass ;;
      3\ *) do_boot_behaviour ;;
      4\ *) do_internationalisation_menu ;;
      *) whiptail --msgbox "[ERROR] Imposible reconocer la selección" 20 60 1 ;;
    esac || whiptail --msgbox "Hay un error tratando de cargar el servicio $FUN" 20 60 1
  else
    exit 1
  fi
done
