#
# bspwm-specific config
#

if [[ ! ":${XDG_CURRENT_DESKTOP,,}:" =~ ":sway:" ]]; then
  return
fi

export MEDIA_PLAYER='umpv'
