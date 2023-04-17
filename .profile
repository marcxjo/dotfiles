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

for path in ${user_paths[@]}
do
  if [[ -d $path ]]
  then
    appendpath $path
  fi
done

unset user_paths
unset appendpath

export PATH

if [[ $(which nvim) ]]
then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

if [[ $(which nvim) ]]
then
  export VISUAL=nvim
else
  export VISUAL=vim
fi

export BROWSER=firefox

