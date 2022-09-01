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

# Primitive transparency for all XTerm windows
[ -n "$XTERM_VERSION" ] && transset-df --id "$WINDOWID" 0.9 > /dev/null

# Custom PS1
export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[m\]:\[\e[32m\]\W\[\e[m\] $(__git_ps1 "(\[\e[37m\]%s\[\e[m\])")'$'\n\[\e[35m\]»\[\e[m\] '

# Envvars sourced by my custom scripts
export SCRIPT_TMP_DIR="/tmp/${USER}"
mkdir -pm 0750 "${SCRIPT_TMP_DIR}"

# User specific aliases and functions

alias ls="ls --color=auto"

hex-to-rgb() {
  printf "%-3d %-3d %d" "0x${1:1:2}" "0x${1:3:2}" "0x${1:5:2}"
}

rgb-to-hex() {
  printf "#%02X%02X%02X" "${1}" "${2}" "${3}"
}

wwindow() {
  # Simple script to rename windows while running a process
  # Mostly useful for TUI apps that don't change the window name

  old_wm_name="$(xprop -id $(xdotool getactivewindow) WM_NAME | cut -d"\"" -f2)"
  old_net_wm_name="$(xprop -id $(xdotool getactivewindow) _NET_WM_NAME | cut -d"\"" -f2)"

  if [ -n "${2+x}" ]; then
    new_name="${2}"
  else
    new_name="${1}"
  fi

  xprop -id $(xdotool getactivewindow) -format _NET_WM_NAME 8s -set WM_NAME "${new_name}"
  xprop -id $(xdotool getactivewindow) -format _NET_WM_NAME 8s -set _NET_WM_NAME "${new_name}"
  ${1}
  xprop -id $(xdotool getactivewindow) -format _NET_WM_NAME 8s -set WM_NAME "${old_wm_name}"
  xprop -id $(xdotool getactivewindow) -format _NET_WM_NAME 8s -set _NET_WM_NAME "${old_net_wm_name}"

  return 0
}

get-gnome-shell-extension() {
  gethub -p "gnome-shell-extensions" ${@}
}
