#!/bin/sh

KEY_DIR=${KEY_DIR:-${HOME}/.ssh}

# Functions ####################################################################

function get_key_domain () {
  # Get the key's associated host/alias and username as a 2-array
  local keyname=${1}

  echo ${keyname} | sed 's|id_rsa\.||;s|_| |'
}

function ls_ssh_keys () {
  # List all key basenames (i.e., non-public keynames)
  local dir=${1}

  ls ${dir} | grep -P '^id_rsa.*(?<!pub)$'
}

function get_ssh_key_fingerprint () {
  # Get and SSH key's fingerprint - must pass the full path string
  keypath=${1}

  ssh-keygen -lf ${keypath}  | awk '{print $2}'
}

function check_key_loaded () {
  # Check by fingerprint whether a key is already registered with the SSH agent
  local fingerprint=${1}

  ssh-add -l | grep -q ${fingerprint}
}

# Startup ######################################################################

if [ ! -S ${HOME}/.ssh/ssh_auth_sock ]; then
  eval $(ssh-agent -s)
  ln -sf "$SSH_AUTH_SOCK" ${HOME}/.ssh/ssh_auth_sock
fi

export SSH_AUTH_SOCK=${HOME}/.ssh/ssh_auth_sock

# Key Registration #############################################################

if [[ ! $(which pass 2>/dev/null) ]]
then
  echo "pass is not installed"
  echo "Can not register ssh-keys"
  exit 1
fi

for key in $(ls_ssh_keys ${KEY_DIR})
do
  domain_components=( $(get_key_domain $key) )
  fingerprint=$(get_ssh_key_fingerprint ${KEY_DIR}/${key})
  is_loaded=$(check_key_loaded ${fingerprint})

  if [[ ${is_loaded} -eq 0 ]]
  then
    continue
  fi

  SSH_HOST=${domain_components[0]} \
  SSH_USER=${domain_components[1]} \
  SSH_ASKPASS_REQUIRE=force \
  SSH_ASKPASS=$(which ssh-pass.sh) \
  ssh-add ${KEY_DIR}/${key} < /dev/null
done

unset SSH_HOST
unset SSH_USER
