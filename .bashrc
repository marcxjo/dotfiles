# .bashrc

# User specific aliases and functions

alias ls='ls --color=auto'

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

# Source Arch nvm init if present
[ -n "$NVM_DIR" ] && [ -f '/usr/share/nvm/init-nvm.sh' ] && . '/usr/share/nvm/init-nvm.sh'

# Custom PS1
export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[m\]:\[\e[32m\]\W\[\e[m\] $(__git_ps1 "(\[\e[37m\]%s\[\e[m\])")'$'\n\[\e[35m\]»\[\e[m\] '
