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

# Primitive transparency for all XTerm windows
[ -n "$XTERM_VERSION" ] && transset-df --id "$WINDOWID" 0.9 > /dev/null

# Custom PS1
export PS1='\[\e[34m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\]:\[\e[33m\]\W\[\e[m\] $(__git_ps1 "(\[\e[36m\]%s\[\e[m\])")'$'\n» '

export EDITOR=nano

# Add user base to Python path
# See https://stackoverflow.com/a/38112757
export PYTHONPATH=$(python -c "import site, os; print(os.path.join(site.USER_BASE, 'lib', 'python', 'site-packages'))"):$PYTHONPATH

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

gethub() {
  while getopts :r:p: o; do
    case "$o" in
      r)
        _GIT_ROOT="${OPTARG}"
        shift 2
        ;;
      p)
        _REPO_PREFIX="${OPTARG}"
        shift 2
        ;;
    esac
  done

  GIT_ROOT=${_GIT_ROOT:-$HOME/.local/src}
  [[ ! -d ${GIT_ROOT} ]] && mkdir -p ${GIT_ROOT}

  case "$1" in
    -a|--arch|--abs)
      REPO_PREFIX=${_REPO_PREFIX:-arch}
      git clone ${@:3} https://git.archlinux.org/$2.git ${GIT_ROOT}/${REPO_PREFIX}/$2
      ;;
    -b|--bitbucket)
      REPO_PREFIX=${REPO_PREFIX:-bitbucket}
      git clone ${@:4} bitbucket:$2/$3.git ${GIT_ROOT}/${REPO_PREFIX}/$2/$3
      ;;
    -g|--github)
      REPO_PREFIX=${_REPO_PREFIX:-github}
      git clone ${@:4} github:$2/$3.git ${GIT_ROOT}/${REPO_PREFIX}/$2/$3
      ;;
    -u|--aur)
      REPO_PREFIX=${_REPO_PREFIX:-aur}
      git clone ${@:3} https://aur.archlinux.org/$2.git ${GIT_ROOT}/${REPO_PREFIX}/$2
      ;;
    *)
      echo "Error: must select repo Github, ABS, or AUR."
      return 2
      ;;
  esac

  return 0
}

get-gnome-shell-extension() {
  gethub -p "gnome-shell-extensions" ${@}
}
