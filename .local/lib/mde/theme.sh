#!/bin/bash

declare -r CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

declare -A APP_CONFIG_DIRS=(
  ['sway']="${CONFIG_HOME}/sway"
  ['tym']="${CONFIG_HOME}/tym"
  ['waybar']="${CONFIG_HOME}/waybar"
)

# Private functions ############################################################

__link_theme_file() {
  local -r theme_to_set="$1"
  local -r current_theme_file="$2"

  if [[ ! -f "$current_theme_file" ]]; then
    echo "Unable to set theme - files does not exist"
  fi

  ln -sfn "$theme_to_set" "$current_theme_file"
}

# tym ##########################################################################

set_tym_theme() {
  local -r theme_name="$1"

  local -r config_dir="${APP_CONFIG_DIRS['tym']}"

  __link_theme_file "${config_dir}/themes/${theme_name}.lua" "${config_dir}/theme.lua"
}

ls_tym_themes() {
  local -r themes_dir="${APP_CONFIG_DIRS['tym']}/themes"

  find "${themes_dir}" -exec basename {} .lua \;
}

# sway #########################################################################

set_sway_theme() {
  local -r theme_name="$1"

  local -r config_dir="${APP_CONFIG_DIRS['sway']}"

  __link_theme_file "${config_dir}/themes/${theme_name}.conf" "${config_dir}/theme.conf"
}

ls_sway_themes() {
  local -r themes_dir="${APP_CONFIG_DIRS['sway']}/themes"

  find "${themes_dir}" -exec basename {} .conf \;
}

# waybar #######################################################################

set_waybar_theme() {
  local -r theme_name="$1"

  local -r config_dir="${APP_CONFIG_DIRS['waybar']}"

  __link_theme_file "${config_dir}/themes/${theme_name}.css" "${config_dir}/theme.css"
}

ls_waybar_themes() {
  local -r themes_dir="${APP_CONFIG_DIRS['waybar']}/themes"

  find "${themes_dir}" -exec basename {} .css \;
}

# Public functions #############################################################

set_app_theme() {
  local -r app_name="$1"

  case "$app_name" in
  'all')
    set_tym_theme "$2"
    set_sway_theme "$2"
    set_waybar_theme "$2"
    ;;
  'tym')
    set_tym_theme "$2"
    ;;
  'sway')
    set_sway_theme "$2"
    ;;
  'waybar')
    set_waybar_theme "$2"
    ;;
  *)
    echo 'Unsupported app!'
    return 1
    ;;
  esac
}

ls_app_themes() {
  local -r app_name="$1"

  case "$app_name" in
  'tym')
    ls_tym_themes
    ;;
  'sway')
    ls_sway_themes
    ;;
  'waybar')
    ls_waybar_themes
    ;;
  *)
    echo 'Unsupported app!'
    return 1
    ;;
  esac
}

# Main loop ####################################################################

declare -r APP_NAME="$1"
shift

case "$1" in
'set')
  set_app_theme "$APP_NAME" "$2" || exit 1
  ;;
'ls')
  ls_app_themes "$APP_NAME" || exit 1
  ;;
*)
  echo "Unsupported command!"
  exit 1
esac

exit 0
