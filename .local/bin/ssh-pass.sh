#!/bin/bash

if [[ -z "${SSH_HOST:-}" ]]
then
  echo "Exiting with status 1"
  echo "Hostname not set"
  exit 1
fi

if [[ -z "${SSH_USER:-}" ]]
then
  echo "Exiting with status 1"
  echo "Username not set"
  exit 1
fi

__pass() {
  PASSWORD_STORE_DIR="$HOME/.config/pass/ssh" pass "$@"
}

__pass ${SSH_HOST}/${SSH_USER} | head -n1
