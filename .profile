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
appendpath "${HOME}/.local/share/gem/ruby/3.0.0/bin"

unset appendpath

export PATH
