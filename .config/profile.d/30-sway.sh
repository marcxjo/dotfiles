#
# bspwm-specific config
#

if [[ ! ":${XDG_CURRENT_DESKTOP,,}:" =~ ":sway:" ]]; then
  return
fi

SWAY_SCRIPTS_DIR="${HOME}/.config/sway/scripts"

[[ ! ":${PATH}:" =~ ":${SWAY_SCRIPTS_DIR}:" ]] &&
  [[ -d "${SWAY_SCRIPTS_DIR}" ]] &&
  export PATH="${PATH}:${SWAY_SCRIPTS_DIR}"

unset SWAY_SCRIPTS_DIR

export MEDIA_PLAYER='umpv'
export MDE_BG_PICTURES_DIR="${HOME}/.local/share/backgrounds"
export JOT_EDITOR='writer'

# Make Firefox behave, otherwise all of its context menus go nuts
export MOZ_ENABLE_WAYLAND=1

if [ -n "$XDG_RUNTIME_DIR" ] && [ ! -f "${XDG_RUNTIME_DIR}/sway-env" ]; then
  printenv | grep -E '^(WAYLAND_DISPLAY|XDG_RUNTIME_DIR|DBUS_SESSION_BUS_ADDRESS|SWAYSOCK)=' > "${XDG_RUNTIME_DIR}/sway-env"
fi
