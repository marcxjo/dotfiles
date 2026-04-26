#!/usr/bin/env bash

lock_screen() {
  [ -f "$MDE_BG_CONFIG" ] && read -r bg <"$MDE_BG_CONFIG"
  exec swaylock -f -i "$bg" -s fill
}
