#
# GNOME-specific config
#

if [[ "${XDG_CURRENT_DESKTOP,,}" != "gnome" ]]; then
  return
fi

export MEDIA_PLAYER='celluloid'
