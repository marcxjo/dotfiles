# .bashrc

try_source() {
  local _file=${1}

  [ -n $_file -a -f $_file ] && . $_file
}

# Source global definitions
try_source /etc/bash.bashrc

# Source git prompt definition
try_source /usr/share/git/completion/git-prompt.sh

# Source local environment
try_source $HOME/.profile

# Source custom startup scripts
# Don't bail if they break
try_source $HOME/.local/bin/startup || true

# Custom PS1
export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[m\]:\[\e[32m\]\W\[\e[m\] $(__git_ps1 "(\[\e[37m\]%s\[\e[m\])")'$'\n\[\e[35m\]»\[\e[m\] '

# User specific aliases and functions

alias ls="ls --color=auto"

hex-to-rgb() {
  printf "%-3d %-3d %d" "0x${1:1:2}" "0x${1:3:2}" "0x${1:5:2}"
}

rgb-to-hex() {
  printf "#%02X%02X%02X" "${1}" "${2}" "${3}"
}

is_running() {
  local _process=${1}

  which $_process &> /dev/null && pgrep -x $_process &> /dev/null
}

