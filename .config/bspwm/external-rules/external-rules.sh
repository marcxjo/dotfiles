#!/bin/bash

declare -r window_id="$1"
declare -r window_class="$2"
declare -r window_instance="$3"

declare -r window_role="$(xprop -id "$window_id" WM_WINDOW_ROLE | sed '/^WM_WINDOW_ROLE/!d ; s/^.* = "\(.*\)"/\1/')"

declare -i WINDOW_PLACEMENT_W WINDOW_PLACEMENT_H WINDOW_PLACEMENT_X WINDOW_PLACEMENT_Y
declare WINDOW_NAME

# if [[ " ${window_class,,} " =~ " mpv " ]]; then
#   _rectangle=$(${HOME}/.config/bspwm/external-rules/calculate-placement.sh 'mpv')
#   echo "state=floating sticky=on focus=off rectangle=${_rectangle}"
#   exit 0
# fi
#
# if [[ " ${window_role,,} " =~ " omnibox " ]]; then
#   _rectangle=$(${HOME}/.config/bspwm/external-rules/calculate-placement.sh 'omnibox')
#   echo "state=floating sticky=on rectangle=${_rectangle}"
#   exit 0
# fi

if [[ " ${window_class,,} " =~ " firefox " ]]; then
  _rectangle=$(${HOME}/.config/bspwm/external-rules/calculate-placement.sh 'firefox')
  echo "state=floating sticky=on focus=off rectangle=${_rectangle}"
  exit 0
fi
