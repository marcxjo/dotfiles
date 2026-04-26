#!/usr/bin/env bash

MDE_BG_CONFIG="${XDG_CONFIG_HOME:-${HOME}/.config}/mde/background"

. "${MDE_LIB_DIR}/screen/${XDG_SESSION_DESKTOP}.sh"

case "$1" in
'lock')
  lock_screen
  ;;
esac
