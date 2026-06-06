#
# bspwm-specific config
#

if [[ ! ":${XDG_CURRENT_DESKTOP,,}:" =~ ":i3:" ]]; then
  return
fi

export MEDIA_PLAYER='umpv'
export MDE_BG_PICTURES_DIR="${HOME}/.local/share/backgrounds"
export TMP_FILE_EDITOR='writer'
