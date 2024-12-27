#
# Xfce-specific config
#

if [[ "${XDG_CURRENT_DESKTOP,,}" != "xfce" ]]; then
  return
fi

export MEDIA_PLAYER='umpv'
