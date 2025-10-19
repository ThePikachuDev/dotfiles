#!/bin/bash

choice=$(echo -e "Logout\nReboot\nShutdown" | dmenu -i -p "Power Menu:")

case "$choice" in
  Logout)
    i3-msg exit
    ;;
  Reboot)
    systemctl reboot
    ;;
  Shutdown)
    systemctl poweroff
    ;;
esac

