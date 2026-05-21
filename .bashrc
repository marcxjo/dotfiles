# .bashrc

# Disable checking for non-constant source - not hardcoding my envars for no
# shell linter
# shellcheck disable=SC1090

# Disable cd guard - we _want_ to fail if the proj dir doesn't exist
# shellcheck disable=SC2164

alias grep='grep --color=auto'
alias ls='ls --color=auto'

if [ -d "${HOME}/.config/bashrc.d" ]; then
  for script in "${HOME}/.config/bashrc.d"/*.sh; do
    # Shellcheck can't verify `source` on variable filenames
    # shellcheck disable=SC1090
    [ -r "$script" ] && . "$script"
  done
fi

# Source git prompt definition
[ -r '/usr/share/git/completion/git-prompt.sh' ] && . '/usr/share/git/completion/git-prompt.sh'

# Custom PS1
# Add git prompt if we can locate it
if type -t __git_ps1 >/dev/null; then
    export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[m\]:\[\e[32m\]\W\[\e[m\] $(__git_ps1 "(\[\e[37m\]%s\[\e[m\])")'$'\n\[\e[35m\]»\[\e[m\] '
else
  if [ -r /usr/share/git/git-prompt.sh ]; then
    . /usr/share/git/git-prompt.sh
    export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[m\]:\[\e[32m\]\W\[\e[m\] $(__git_ps1 "(\[\e[37m\]%s\[\e[m\])")'$'\n\[\e[35m\]»\[\e[m\] '
  else
    export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[m\]:\[\e[32m\]\W\[\e[m\]'$'\n\[\e[35m\]»\[\e[m\] '
  fi
fi

# Source custom startup scripts
# Don't bail if they break
[ -r "$HOME/.local/share/startup.d/startuprc" ] && . "$HOME/.local/share/startup.d/startuprc"

[ -r "$HOME/.LESS_TERMCAP" ] && . "$HOME/.LESS_TERMCAP"

[ -r '/usr/share/nvm/init-nvm.sh' ] && . '/usr/share/nvm/init-nvm.sh'

if command -v direnv &>/dev/null; then
  eval "$(direnv hook bash)"
fi
