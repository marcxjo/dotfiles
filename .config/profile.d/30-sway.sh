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
