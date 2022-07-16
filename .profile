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

user_paths=(
  "${HOME}/bin"
  "${HOME}/.local/bin"
  "${HOME}/.local/share/gem/ruby/3.0.0/bin"
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
