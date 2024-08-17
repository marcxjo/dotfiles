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

unset prepend_path

export PATH

if command -v nvim &>/dev/null; then
  export EDITOR=nvim
  export VISUAL=nvim
fi

if command -v firefox &>/dev/null; then
  export BROWSER=firefox
fi

[[ -f $HOME/.bashrc ]] && . "$HOME/.bashrc"

if [[ -d $HOME/.config/profile.d ]]; then
  for profile in $HOME/.config/profile.d/*.sh; do
    # Shellcheck can't verify `source` on variable filenames
    # shellcheck disable=SC1090
    [[ -r "$profile" ]] && . "$profile"
  done
fi
