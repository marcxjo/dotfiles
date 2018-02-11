# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# XTerm Transparency
[ -n "$XTERM_VERSION" ] && transset-df --id "$WINDOWID" 0.9 > /dev/null

# Custom PS1
export PS1="[\[\e[34m\]\u\[\e[m\]@\[\e[32m\]\h \[\e[33m\]\W\[\e[m\]]\$ "
