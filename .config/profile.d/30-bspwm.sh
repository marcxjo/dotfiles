#
# bspwm-specific config
#

if [[ "${XDG_SESSION_DESKTOP,,}" != "bspwm" ]]; then
  return
fi

export MEDIA_PLAYER='umpv'
