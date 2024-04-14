#!/bin/bash

# TODO: rename this script to ssh-pw.sh
# It no longer depends directly on pass

PW_CMD=$(command -v pw)

if [[ ${SSH_HOST:-x} == "x" ]]
then
  echo "Exiting with status 1"
  echo "Hostname not set"
  exit 1
fi

if [[ ${SSH_USER:-x} == "x" ]]
then
  echo "Exiting with status 1"
  echo "Username not set"
  exit 1
fi

${PW_CMD} ssh ${SSH_HOST}/${SSH_USER} | head -n1
