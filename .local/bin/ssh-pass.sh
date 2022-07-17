#!/bin/bash

PASS_CMD=$(which pass)

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

${PASS_CMD} ssh/${SSH_HOST}/${SSH_USER} | head -n1
