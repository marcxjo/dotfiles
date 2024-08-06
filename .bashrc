# .bashrc

# Disable checking for non-constant source - not hardcoding my envars for no
# shell linter
# shellcheck disable=SC1090

# Disable cd guard - we _want_ to fail if the proj dir doesn't exist
# shellcheck disable=SC2164

# User specific aliases and functions
alias grep='grep --color=auto'
alias ls='ls --color=auto'

run() {
  setsid -f -- "$@" 0<&- &>/dev/null
}

join_array() {
  local -r _delimiter="$1"
  local -ra _arr=("${@:2}")

  (IFS="$_delimiter"; echo "${_arr[*]}")
}

build_path() {
  local -ar _segments=("$@")

  # HACK - overwriting a global variable with a local one
  # Any cleaner way I can find to do this is also unnecessarily verbose
  join_array '/' "${_segments[@]}"
}

proj() {
  local -r _workspace_cache="$(git profile projs workspace cache get)"

  [[ -z "$_workspace_cache" ]] &&
    echo "Cache file does not exist" >&2 2>&1 &&
    return 1

  local -r _preview_cmd="GIT_DIR={}/.git git ls-files"

  local -r _repo="$(fzf --preview="$_preview_cmd" <"$_workspace_cache")"

  cd "$_repo"
}

pcache() {
  git profile projs workspace default cache update
}

# Source git prompt definition
[ -r '/usr/share/git/completion/git-prompt.sh' ] && . '/usr/share/git/completion/git-prompt.sh'

# Source custom startup scripts
# Don't bail if they break
[ -r "$HOME/.config/startup/startuprc" ] && . "$HOME/.config/startup/startuprc"

# Custom PS1
export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[m\]:\[\e[32m\]\W\[\e[m\] $(__git_ps1 "(\[\e[37m\]%s\[\e[m\])")'$'\n\[\e[35m\]»\[\e[m\] '
