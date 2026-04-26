#!/bin/bash

declare -r CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
declare -r MDE_THEMEGEN_DIR="${MDE_THEMEGEN_DIR:-${HOME}/.local/lib/mde/themegen}"

declare -A APP_CONFIG_DIRS=(
  ['i3']="${CONFIG_HOME}/i3"
  ['sway']="${CONFIG_HOME}/sway"
  ['tym']="${CONFIG_HOME}/tym"
  ['waybar']="${CONFIG_HOME}/waybar"
)

# Private functions ############################################################

__get_theme_variables() {
  local -r theme_name="$1"
  local varnames_csv

  while read -r line; do
    if [ -z "$line" ]; then
      continue
    fi

    if [ -z "$varnames_csv" ]; then
      varnames_csv="\$$line"
    else
      varnames_csv+=",\$${line}"
    fi
  done < <(awk 'NF {gsub("=", " ", $0); print $2}' "${HOME}/.cache/mde/themes/${theme_name}.sh")

  echo "$varnames_csv"
}

__set_app_theme() {
  local -r app_name="$1"
  local -r theme_name="$2"

  local -r themes_dir="${APP_CONFIG_DIRS[$app_name]}/themes"

  if ! pushd "$themes_dir" >/dev/null; then
    return 1
  fi

  ln -sfn "${theme_name}" 'current'

  if ! popd >/dev/null; then
    return 1
  fi
}

__gen_app_theme() {
  local -r app_name="$1"
  local -r theme_name="$2"
  local -r destdir="${APP_CONFIG_DIRS[$app_name]}/themes/${theme_name}"
  local -r theme_script="${HOME}/.cache/mde/themes/${theme_name}.sh"

  . "$theme_script" || return 1

  mkdir -p "$destdir"
  [ -d "$destdir" ] && rm -rf "$destdir"/*

  varlist="$(__get_theme_variables "$theme_name")"

  pushd "${MDE_LIB_DIR}/theme/${app_name}" >/dev/null || return 1

  for file in *.in; do
    cat "$file" | envsubst "$varlist" >>"${destdir}/${file%.in}"
  done

  popd >/dev/null || return 1
}

# tym ##########################################################################

gen_tym_theme() {
  local -r app_name='tym'
  local -r theme_name="$1"

  __gen_app_theme "$app_name" "$theme_name"
}

set_tym_theme() {
  local -r app_name='tym'
  local -r theme_name="$1"

  __set_app_theme "$app_name" "$theme_name"
}

ls_tym_themes() {
  local -r themes_dir="${APP_CONFIG_DIRS['tym']}/themes"

  find "${themes_dir}" -exec basename {} .lua \;
}

# i3 #########################################################################

gen_i3_theme() {
  local -r app_name='i3'
  local -r theme_name="$1"

  __gen_app_theme "$app_name" "$theme_name"
}

set_i3_theme() {
  local -r app_name='i3'
  local -r theme_name="$1"

  __set_app_theme "$app_name" "$theme_name"
}

ls_i3_themes() {
  local -r themes_dir="${APP_CONFIG_DIRS['i3']}/themes"

  find "${themes_dir}" -exec basename {} .conf \;
}

# sway #########################################################################

gen_sway_theme() {
  local -r app_name='sway'
  local -r theme_name="$1"

  __gen_app_theme "$app_name" "$theme_name"
}

set_sway_theme() {
  local -r app_name='sway'
  local -r theme_name="$1"

  __set_app_theme "$app_name" "$theme_name"
}

ls_sway_themes() {
  local -r themes_dir="${APP_CONFIG_DIRS['sway']}/themes"

  find "${themes_dir}" -exec basename {} .conf \;
}

# waybar #######################################################################

gen_waybar_theme() {
  local -r app_name='waybar'
  local -r theme_name="$1"

  __gen_app_theme "$app_name" "$theme_name"
}

set_waybar_theme() {
  local -r app_name='waybar'
  local -r theme_name="$1"

  __set_app_theme "$app_name" "$theme_name"
}

ls_waybar_themes() {
  local -r themes_dir="${APP_CONFIG_DIRS['waybar']}/themes"

  find "${themes_dir}" -exec basename {} .css \;
}

# Public functions #############################################################

set_theme() {
  local -r theme_name="$1"
  shift

  set_tym_theme "$theme_name"
  set_i3_theme "$theme_name"
  set_sway_theme "$theme_name"
  set_waybar_theme "$theme_name"
}

gen_theme() {
  local -r theme_name="$1"
  shift

  gen_tym_theme "$theme_name"
  gen_i3_theme "$theme_name"
  gen_sway_theme "$theme_name"
  gen_waybar_theme "$theme_name"
}

ls_themes() {
  local -r themes_dir="${HOME}/.cache/mde/themes"

  find "${themes_dir}" -exec basename -s .sh {} +
}

# Main loop ####################################################################

main() {
  local -r subcmd="$1"
  shift

  case "$subcmd" in
  'set')
    set_theme "$@" || exit 1
    ;;
  'gen')
    gen_theme "$@" || exit 1
    ;;
  'ls')
    ls_themes
    ;;
  *)
    echo "Unsupported command!"
    exit 1
    ;;
  esac
}

main "$@"
