# .bashrc

# User specific aliases and functions

alias ls="ls --color=auto"

try_source() {
  local _file=${1}

  [ -f $_file ] && . $_file
}

is_running() {
  local _process=${1}

  which $_process &> /dev/null && pgrep -x $_process &> /dev/null
}

hex_to_rgb() {
  printf "%d %d %d" "0x${1:1:2}" "0x${1:3:2}" "0x${1:5:2}"
}

# printf in technicolor
cprintf() {
  local _color=${1}
  local _printf_fmt=${2}
  local _printf_txt=${@:3}

  local _rgb=( $(hex_to_rgb "$_color") )

  local _esc_start="\033[38;2;${_rgb[0]};${_rgb[1]};${_rgb[2]}m"
  local _esc_end="\033[m"

  printf "${_esc_start}${_printf_fmt}${_esc_end}" "${_printf_txt}"
}

export -f try_source
export -f is_running
# Heh, cprintf fails to run in a subshell if this is not exported
export -f hex_to_rgb
export -f cprintf

# Source git prompt definition
try_source /usr/share/git/completion/git-prompt.sh

# Source custom startup scripts
# Don't bail if they break
try_source $HOME/.config/startup/startuprc || true

# Source Arch nvm init if present
[[ -z $NVM_DIR ]] && try_source /usr/share/nvm/init-nvm.sh

# Custom PS1
export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[m\]:\[\e[32m\]\W\[\e[m\] $(__git_ps1 "(\[\e[37m\]%s\[\e[m\])")'$'\n\[\e[35m\]»\[\e[m\] '

