# Append custom paths
appendpath () {
  case ":$PATH:" in
    *:"$1":*)
      ;;
    *)
      PATH="${PATH:+$PATH:}$1"
      ;;
    esac
}

appendpath "${HOME}/bin"
appendpath "${HOME}/.local/bin"
appendpath "${HOME}/.gem/ruby/2.7.0/bin"

# Root directory for Python virtual environments
VENV_ROOT=${HOME}/.local/opt

for dir in $(ls $VENV_ROOT); do
  appendpath $VENV_ROOT/$dir/bin
done

unset appendpath

export PATH
