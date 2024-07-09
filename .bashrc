# .bashrc

# User specific aliases and functions

alias ls='ls --color=auto'

alias proj='cd "$(~/.local/lib/common/proj)"'

# Source git prompt definition
GIT_PROMPT_FILE='/usr/share/git/completion/git-prompt.sh'
[ -f $GIT_PROMPT_FILE ] && . $GIT_PROMPT_FILE

# Source custom startup scripts
# Don't bail if they break
STARTUP_RC="$HOME/.config/startup/startuprc"
[ -f $STARTUP_RC ] && . $STARTUP_RC

# Source Arch nvm init if present
NVM_INIT_SCRIPT='/usr/share/nvm/init-nvm.sh'
[ -n $NVM_DIR ] && [ -f $NVM_INIT_SCRIPT ] && . $NVM_INIT_SCRIPT

# Custom PS1
export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[m\]:\[\e[32m\]\W\[\e[m\] $(__git_ps1 "(\[\e[37m\]%s\[\e[m\])")'$'\n\[\e[35m\]»\[\e[m\] '
