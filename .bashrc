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
export PS1="\[\e[34m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\]:\[\e[33m\]\W\[\e[m\] » "

# Add user base to Python path
# See https://stackoverflow.com/a/38112757
export PYTHONPATH=$(python -c "import site, os; print(os.path.join(site.USER_BASE, 'lib', 'python', 'site-packages'))"):$PYTHONPATH

# User specific aliases and functions

function wwindow () {
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
xprop -id $(xdotool getactivewindow) -format _NET_WM_NAME 8s -set WM_NAME "$old_wm_name"
xprop -id $(xdotool getactivewindow) -format _NET_WM_NAME 8s -set _NET_WM_NAME "$old_net_wm_name"

return 0
}

function gethub () {
  git clone ${@:3} https://github.com/$1/$2.git ${HOME}/.local/src/github-$1-$2

  return 0
}
