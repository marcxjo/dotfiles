# Append custom paths
append_path() {
  case ":$PATH:" in
  *:"$1":*) ;;
  *)
    PATH="${PATH:+$PATH:}${1}"
    ;;
  esac
}

# Add support for user paths to user-installed commands
append_path "${HOME}/.local/bin"
append_path "${HOME}/bin"

[[ -d $HOME/.local/opt/JetBrains/Toolbox/scripts ]] &&
  append_path "${HOME}/.local/opt/JetBrains/Toolbox/scripts"

unset prepend_path

export PATH

if command -v nvim &>/dev/null; then
  export EDITOR=nvim
  export VISUAL=nvim
fi

if command -v firefox &>/dev/null; then
  export BROWSER=firefox
fi

if [[ -d $HOME/.config/profile.d ]]; then
  for profile in "$HOME/.config/profile.d"/*.sh; do
    # Shellcheck can't verify `source` on variable filenames
    # shellcheck disable=SC1090
    [[ -r "$profile" ]] && . "$profile"
  done
fi

# I don't want this on either way, but historically, when closing a solution in Rider,
# my CPU goes absolutely nuts when this is _is_ toggled on
export DOTNET_TELEMETRY_OPTOUT=1

# Make FZF look snazzy
export FZF_DEFAULT_OPTS='--border=rounded --layout=reverse --preview-window=down,75%,noinfo,wrap'

[[ -f ~/.bashrc ]] && . ~/.bashrc
