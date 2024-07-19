# Append custom paths
prepend_path() {
  case ":$PATH:" in
  *:"$1":*) ;;
  *)
    PATH="${1}${PATH:+:$PATH}"
    ;;
  esac
}

export NVM_DIR="${HOME}/.nvm"
export GOROOT="${HOME}/.go/go1.22.2"
export GOPATH="${HOME}/.go"

# Add support for user paths to user-installed commands
prepend_path "${HOME}/bin"
prepend_path "${HOME}/.local/bin"
prepend_path "${HOME}/.local/share/gem/ruby/3.0.0/bin"
prepend_path "${HOME}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin"
prepend_path "${HOME}/.cargo/bin"
prepend_path "${HOME}/.dotnet/tools"
prepend_path "${GOROOT}/bin"

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
