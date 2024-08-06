# Append custom paths
prepend_path() {
  case ":$PATH:" in
  *:"$1":*) ;;
  *)
    PATH="${1}${PATH:+:$PATH}"
    ;;
  esac
}

# Add support for user paths to user-installed commands
prepend_path "${HOME}/bin"
prepend_path "${HOME}/.local/bin"

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
    [[ -r "$profile" ]] && . "$profile"
  done
fi
