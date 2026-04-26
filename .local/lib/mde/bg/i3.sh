#!/usr/bin/env bash

load_bg() {
  [ -r "$MDE_BG_CONFIG" ] && read -r bg <"$MDE_BG_CONFIG"

  xwallpaper --zoom "$bg" &
}

start_bg_watcher() {
  # shellcheck disable=SC2034
  # We know we're not reading the event, but we can't not set a variable at all
  inotifywait -qme close_write "$MDE_BG_CONFIG" |
    while read -r event; do
      load_bg
    done
}

set_bg() {
  local bg="$1"

  echo "$bg" >"$MDE_BG_CONFIG"
}

select_bg() {
  nsxiv "$MDE_BG_PICTURES_DIR"
}
