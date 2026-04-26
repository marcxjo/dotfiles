#!/usr/bin/env bash

start_bar() {
  pgrep -x waybar >/dev/null || exec waybar
}

reload_bar() {
  pkill -x -USR2 waybar
}
