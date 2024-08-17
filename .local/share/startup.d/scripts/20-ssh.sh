#!/bin/bash

KEY_DIR=${KEY_DIR:-${HOME}/.ssh}

# Functions ####################################################################

get_key_domain() {
  # Get the key's associated host/alias and username as a 2-array
  local keyname=${1}

  echo "${keyname//__/ }"
}

ls_ssh_keys() {
  # List all key basenames (i.e., non-public keynames)
  local dir=${1}

  # List all the public keys since we can key off of their filenames to
  # locate each respective private key
  ls "${dir}" | grep "\.pub$" | sed 's|\.pub$||'
}

get_ssh_key_fingerprint() {
  # Get an SSH key's fingerprint - must pass the full path string
  keypath=${1}

  ssh-keygen -lf "${keypath}" | awk '{print $2}'
}

check_key_loaded() {
  # Check by fingerprint whether a key is already registered with the SSH agent
  local fingerprint=${1}

  ssh-add -l | grep -q "${fingerprint}"
}

# Startup ######################################################################

if [ ! -S "${HOME}/.ssh/ssh_auth_sock" ]; then
  eval "$(ssh-agent -s)"
  ln -sf "$SSH_AUTH_SOCK" "${HOME}/.ssh/ssh_auth_sock"
fi

export SSH_AUTH_SOCK=${HOME}/.ssh/ssh_auth_sock

# Key Registration #############################################################

if ! command -v pw &>/dev/null; then
  echo "pw is not installed"
  echo "Can not register ssh-keys"
  return 1
fi

for key in $(ls_ssh_keys "${KEY_DIR}"); do
  domain_components=($(get_key_domain $key))
  fingerprint=$(get_ssh_key_fingerprint "${KEY_DIR}/${key}")

  if check_key_loaded "${fingerprint}"; then
    continue
  fi

  SSH_HOST=${domain_components[0]} \
    SSH_USER=${domain_components[1]} \
    SSH_ASKPASS_REQUIRE=force \
    SSH_ASKPASS=$(command -v ssh-pass.sh) \
    ssh-add "${KEY_DIR}/${key}" </dev/null
done

unset SSH_HOST
unset SSH_USER
