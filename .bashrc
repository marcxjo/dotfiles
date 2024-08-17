# .bashrc

# Disable checking for non-constant source - not hardcoding my envars for no
# shell linter
# shellcheck disable=SC1090

# Disable cd guard - we _want_ to fail if the proj dir doesn't exist
# shellcheck disable=SC2164

alias grep='grep --color=auto'
alias ls='ls --color=auto'

run() {
  setsid -f -- "$@" 0<&- &>/dev/null
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

gethub() {
  [[ ! -r $HOME/.local/lib/git-pclone/common.sh ]] &&
    echo "Unable to source git-pclone library functions" &&
    return 1

  . "${HOME}/.local/lib/git-pclone/common.sh"

  # This duplicates the offset logic in the `main` function of `git-pclone`
  # almost verbatim, but I'd rather do this than try to extract weirdly specific
  # args partitioning logic
  local -ri _opts_separator_index=$(get_index '--' "$@")
  local -ri _opts_offset=$((_opts_separator_index + 1))

  local -a _git_clone_opts

  if [[ $_opts_separator_index -gt 0 ]]; then
    _git_clone_opts=("${@:1:${_opts_offset}}")
  fi

  shift $_opts_offset

  [[ -r ${HOME}/.config/gethub/providers ]] &&
    . "${HOME}/.config/gethub/providers"

  local -r _repo_host="${GIT_PROVIDERS[$1]:-$1}"
  local -ra _repo_path_segments=("${@:2}")
  local -r _repo_path_root=$(git profile projs workspace root get)

  GIT_PCLONE_SRC_ROOT="$_repo_path_root" git profile projs workspace pclone "${_git_clone_opts[@]}" "${_repo_host}" "${_repo_path_segments[@]}"
}

pw() {
  local -r _config_root="${PW_CONFIG_ROOT:-${HOME}/.config/pass}"
  local -r _pw_store_dir="${_config_root}/${1}"

  shift 1

  env PASSWORD_STORE_DIR="${_pw_store_dir}" pass "${@}"
}

# Source git prompt definition
[ -r '/usr/share/git/completion/git-prompt.sh' ] && . '/usr/share/git/completion/git-prompt.sh'

# Source custom startup scripts
# Don't bail if they break
[ -r "$HOME/.local/share/startup.d/startuprc" ] && . "$HOME/.local/share/startup.d/startuprc"

# Custom PS1
export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[m\]:\[\e[32m\]\W\[\e[m\] $(__git_ps1 "(\[\e[37m\]%s\[\e[m\])")'$'\n\[\e[35m\]»\[\e[m\] '
