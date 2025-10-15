#!/usr/bin/env bash

MDE_BG_CONFIG="${XDG_CONFIG_HOME:-${HOME}/.config}/mde/background"

case "$1" in
'lock')
  [ -f "$MDE_BG_CONFIG" ] && read -r bg <"$MDE_BG_CONFIG"
  exec swaylock -f -i "$bg" -s fill
  ;;
esac
