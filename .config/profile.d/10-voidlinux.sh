#
# Void Linux-specific bits
#

if [ ! "$(lsb_release -d | awk '{$1=""; gsub(/^ */, "", $0); print}')" == "Void Linux" ]; then
  return
fi

# We don't need session services if we're just SSHing in
# I might eventually wire up support for SSH-specific services if a compelling
# need arises
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  return
fi

# Enable running user-specific services when running `runit` commands
# unprivileged
export SVDIR="${HOME}/.local/state/service"
export RUNSVDIR="${HOME}/.local/share/runit/runsvdir"

mkdir -p "/run/user/${UID}/runit"

runsvdir -P "$SVDIR" &
