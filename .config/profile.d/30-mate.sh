#
# MATE-specific config
#

if [[ "${XDG_CURRENT_DESKTOP,,}" != "mate" ]]; then
  return
fi

export MEDIA_PLAYER='umpv'
