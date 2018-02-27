# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# XTerm Transparency
[ -n "$XTERM_VERSION" ] && transset-df --id "$WINDOWID" 0.9 > /dev/null

# Custom PS1
export PS1="\[\e[34m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\]:\[\e[33m\]\W\[\e[m\] » "

# User specific aliases and functions

function wtitle () {
	xprop -id ${1} _NET_WM_NAME 2>/dev/null | awk '{gsub(/"/, "");print $3}'
}

export -f wtitle
