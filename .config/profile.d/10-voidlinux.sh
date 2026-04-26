#
# Void Linux-specific bits
#

if [ ! "$(lsb_release -d | awk '{$1=""; gsub(/^ */, "", $0); print}')" == "Void Linux" ]; then
  return
fi

# Enable running user-specific services when running `runit` commands
# unprivileged
export SVDIR="${HOME}/.local/state/service"
export RUNSVDIR="${HOME}/.local/share/runit/runsvdir"

# Don't attempt to start our services if they're already spun up
if pgrep -xu "$USER" runsvdir >/dev/null; then
  return
fi

mkdir -p "${XDG_RUNTIME_DIR:-/run/user/${UID}}/runit"

runsvdir -P "$SVDIR" & 2>/dev/null
