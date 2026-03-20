#
# Void Linux-specific bits
#

if [ "$(lsb_release -d | awk '{$1=""; gsub(/^ */, "", $0); print}')" == "Void Linux" ]; then
  return
fi

# Void Linux user services directory
export SVDIR="${HOME}/.local/share/runit/runsvdir"
