#
# Container-specific config
#

if [[ -z ${container:-} ]]; then
  return
fi

# Hook in direnv so that our env is automatically adjusted when walking
# into repositories
eval "$(direnv hook bash)"

