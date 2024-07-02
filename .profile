# Append custom paths
append_path () {
  case ":$PATH:" in
    *:"$1":*)
      ;;
    *)
      PATH="${PATH:+$PATH:}$1"
      ;;
  esac
}

export NVM_DIR="${HOME}/.nvm"
export GOROOT="${HOME}/.go/go1.22.2"
export GOPATH="${HOME}/.go"

# Add support for user paths to user-installed commands
append_path "${HOME}/bin"
append_path "${HOME}/.local/bin"
append_path "${HOME}/.local/share/gem/ruby/3.0.0/bin"
append_path "${HOME}/.cargo/bin"
append_path "${HOME}/.dotnet/tools"
append_path "${GOROOT}/bin"

unset user_paths
unset append_path

export PATH

if command -v nvim &> /dev/null; then
  export EDITOR=nvim
  export VISUAL=nvim
fi

if command -v firefox &> /dev/null; then
  export BROWSER=firefox
fi

[[ -f $HOME/.bashrc ]] && . $HOME/.bashrc

