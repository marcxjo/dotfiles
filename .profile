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

# Add support for user paths to:
# * Shell scripts
# * Ruby gems
# * Rust crates
user_paths=(
  "${HOME}/bin"
  "${HOME}/.local/bin"
  "${HOME}/.local/share/gem/ruby/3.0.0/bin"
  "${HOME}/.cargo/bin"
)

for path in ${user_paths[@]}; do
  [[ -d $path ]] && appendpath $path
done

unset user_paths
unset appendpath

export PATH

command -v nvim &> /dev/null && export EDITOR=nvim && export VISUAL=vim

command -v firefox &> /dev/null && export BROWSER=firefox

