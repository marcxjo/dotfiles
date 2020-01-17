# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Source local environment
if [ -f "${HOME}/.profile" ]; then
  . "${HOME}/.profile"
fi

# Primitive transparency for all XTerm windows
[ -n "$XTERM_VERSION" ] && transset-df --id "$WINDOWID" 0.9 > /dev/null

# Custom PS1
#export PS1="\[\e[34m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\]:\[\e[33m\]\W\[\e[m\] » "
export PS1="\[\e[34m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\]:\[\e[33m\]\W\[\e[m\] \$(__git_ps1 '(\[\e[36m\]%s\[\e[m\])\n» ')"

# Add user base to Python path
# See https://stackoverflow.com/a/38112757
export PYTHONPATH=$(python -c "import site, os; print(os.path.join(site.USER_BASE, 'lib', 'python', 'site-packages'))"):$PYTHONPATH

# User specific aliases and functions

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

gethub() {
  _GIT_ROOT=$HOME/.local/src
  if [[ ! -d ${_GIT_ROOT} ]]; then
    mkdir -p ${_GIT_ROOT}
  fi

  case "$1" in
    -g|--github)
      git clone ${@:4} https://github.com/$2/$3.git ${_GIT_ROOT}/github/$2/$3
      ;;
    -a|--aur)
      git clone ${@:3} https://aur.archlinux.org/$2.git ${_GIT_ROOT}/aur/$2
      ;;
    -b|--arch|--abs)
      git clone ${@:3} https://git.archlinux.org/$2.git ${_GIT_ROOT}/arch/$2
      ;;
    *)
      echo "Error: must select repo Github, ABS, or AUR."
      return 2
      ;;
  esac

  return 0
}
