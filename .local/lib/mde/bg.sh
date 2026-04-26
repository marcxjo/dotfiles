#!/usr/bin/env bash

MDE_BG_CONFIG="${XDG_CONFIG_HOME:-${HOME}/.config}/mde/background"
MDE_BG_PICTURES_DIR="${MDE_BG_PICTURES_DIR:-$(xdg-user-dir PICTURES)}"

declare MDE_BG_IMG

. "${MDE_LIB_DIR}/bg/${XDG_SESSION_DESKTOP}.sh"

if [[ ${#@} -eq -0 ]]; then
  echo "mde-bg: Must specify subcommand"
  return 1
fi

declare subcmd="$1"
shift

case "$1" in
'-d' | '--directory')
  if [[ -z "$2" ]]; then
    echo "Must specify an image directory path when using --directory switch"
    return 1
  fi

  MDE_BG_PICTURES_DIR="$2"
  shift 2
  ;;
'-i' | '--image')
  if [[ -z "$2" ]]; then
    echo "Must specify an image file path when using --image switch"
    return 1
  fi

  MDE_BG_IMG="$2"
  shift 2
  ;;
*)
  ;;
esac

main() {
  local -r subcmd="$1"

  case "$subcmd" in
  'set')
    set_bg "$MDE_BG_IMG"
    ;;
  'reload')
    load_bg
    ;;
  'start')
    load_bg
    start_bg_watcher
    ;;
  'select')
    select_bg
    ;;
  *)
    echo 'Unsupported command!'
    return 1
    ;;
  esac
}

main "$subcmd"
