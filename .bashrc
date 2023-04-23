# .bashrc

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
  . /etc/bash.bashrc
fi

# Source git prompt definition
if [ -f /usr/share/git/completion/git-prompt.sh ]; then
  . /usr/share/git/completion/git-prompt.sh
fi

# Source local environment
if [ -f "${HOME}/.profile" ]; then
  . "${HOME}/.profile"
fi

if [ -f ${HOME}/.local/bin/startup ]; then
  . ${HOME}/.local/bin/startup || true
fi

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

  which $_process &>/dev/null && pgrep -x $_process &>/dev/null
}

