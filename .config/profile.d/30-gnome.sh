#
# GNOME-specific config
#

if [[ "${XDG_CURRENT_DESKTOP,,}" != "gnome" ]]; then
  return
fi

export STULTO_HEADERBAR_TYPE=0
export LETS_WATCH_MEDIA_PLAYER='celluloid --enqueue'
export YOUTUBE_PL_MEDIA_PLAYER='celluloid --enqueue'
export YT_MEDIA_PLAYER='celluloid --enqueue'
