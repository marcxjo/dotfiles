#!/usr/bin/env bash

declare -i FORCE_RELOAD

. "${MDE_LIB_DIR}/bar/${XDG_SESSION_DESKTOP}.sh"

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
