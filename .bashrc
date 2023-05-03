# .bashrc

try_source() {
  local _file=${1}

  [ -n $_file -a -f $_file ] && . $_file
}

# Source git prompt definition
try_source /usr/share/git/completion/git-prompt.sh

# Source local environment
try_source $HOME/.profile

# Source custom startup scripts
# Don't bail if they break
try_source $HOME/.config/startup/startuprc || true

# Source Arch nvm init if present
[[ -z $NVM_DIR ]] && try_source /usr/share/nvm/init-nvm.sh

# Custom PS1
export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[m\]:\[\e[32m\]\W\[\e[m\] $(__git_ps1 "(\[\e[37m\]%s\[\e[m\])")'$'\n\[\e[35m\]»\[\e[m\] '

# User specific aliases and functions

alias ls="ls --color=auto"

is_running() {
  local _process=${1}

  which $_process &> /dev/null && pgrep -x $_process &> /dev/null
}

