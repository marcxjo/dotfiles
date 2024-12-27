#!/bin/bash

get_float_area() {
  local -r _mon="$1"

  local -r area_width=$(bspc config -m $mon left_padding)
}

declare -r window_id="$1"
declare -r window_class="$2"
declare -r window_instance="$3"

declare -i WINDOW_PLACEMENT_W WINDOW_PLACEMENT_H WINDOW_PLACEMENT_X WINDOW_PLACEMENT_Y
declare WINDOW_NAME

declare -rA RULES=(
#["mpv"]="state=floating sticky=on focus=off rectangle=780x624+220+80"
["stulto"]="state=floating sticky=on rectangle=820x660+35+750"
)

if [[ "x${RULES[${window_class}],,}" == "x" ]]; then
  exit 0
fi

echo "${RULES[${window_class}]}"
