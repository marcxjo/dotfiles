if [[ "${XDG_SESSION_DESKTOP,,}" != "bspwm" ]]; then
  return
fi

export STULTO_HEADERBAR_TYPE=2
export LETS_WATCH_MEDIA_PLAYER='umpv'
export YOUTUBE_PL_MEDIA_PLAYER='umpv'
export YT_MEDIA_PLAYER='umpv'
