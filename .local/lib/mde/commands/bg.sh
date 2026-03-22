#!/usr/bin/env bash

MDE_BG_CONFIG="${XDG_CONFIG_HOME:-${HOME}/.config}/mde/background"
MDE_BG_PICTURES_DIR="${MDE_BG_PICTURES_DIR:-$(xdg-user-dir PICTURES)}"

load_bg() {
  [ -r "$MDE_BG_CONFIG" ] && read -r bg <"$MDE_BG_CONFIG"

  pkill -x swaybg

  swaybg -o '*' -i "$bg" -m fill &
}

start_bg_watcher() {
  # shellcheck disable=SC2034
  # We know we're not reading the event, but we can't not set a variable at all
  inotifywait -qme close_write "$MDE_BG_CONFIG" |
    while read -r event; do
      load_bg
    done
}

set_bg() {
  local bg="$1"

  echo "$bg" >"$MDE_BG_CONFIG"
}

select_bg() {
  imv_config="${HOME}/.config/imv/mde-bg-select.config" imv -r "$MDE_BG_PICTURES_DIR"
}

if [[ ${#@} -eq -0 ]]; then
  echo "mde-bg: Must specify subcommand"
  return 1
fi

declare -r subcmd="$1"
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
*)
  echo "Unrecognized option $1"
  shift
  ;;
esac

main() {
  local -r subcmd="$1"

  case "$subcmd" in
  'set')
    set_bg "$1"
    ;;
  'reload')
    load_bg
    ;;
  'start')
    # Since we're starting the watcher,
    # make sure we have a background in the first place
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
