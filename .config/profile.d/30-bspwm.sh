#
# bspwm-specific config
#

if [[ ! ":${XDG_CURRENT_DESKTOP,,}:" =~ ":bspwm:" ]]; then
  return
fi

export MEDIA_PLAYER='umpv'
