#!/usr/bin/env bash

declare -i FORCE_RELOAD

start_bar() {
  pgrep -x waybar >/dev/null || exec waybar
}

reload_bar() {
  pkill -x -USR2 waybar
}

if [[ ${#@} -eq -0 ]]; then
  echo "mde-bar: Must specify subcommand"
  return 1
fi

declare -r cmd="$1"
shift

case "$1" in
'-f' | '--force')
  FORCE_RELOAD=1
  shift
  ;;
*)
  echo "Unrecognized option $1"
  shift
  ;;
esac

case "$cmd" in
'start')
  start_bar
  ;;
'reload')
  if ! reload_bar && [[ $FORCE_RELOAD -ge 1 ]]; then
    start_bar
  fi
  ;;
*)
  echo "Unrecognized command $cmd"
  return 1
  ;;
esac
