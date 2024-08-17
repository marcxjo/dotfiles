#!/bin/bash

declare -r _window_name="$1"
declare -i _w _h _x _y
declare _window_geometry

if [[ -z "$_window_name" ]]; then
  exit 1
fi

while getopts :d opt; do
  case "$opt" in
  d)
    DEBUG=1
    shift
    ;;
  *)
    exit 1
    ;;
  esac
done

case $_window_name in
'firefox')
  _w=1168
  _h=1352
  _x=2240
  _y=56
  ;;
'mpv')
  _w=800
  _h=640
  _x=2152
  _y=752
  ;;
'omnibox')
  _w=800
  _h=640
  _x=2152
  _y=80
  ;;
*)
  exit 1
  ;;
esac

_window_geometry="${_w}x${_h}+${_x}+${_y}"

echo "${_window_geometry}"

exit 0
