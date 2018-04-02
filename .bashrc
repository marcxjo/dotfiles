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

