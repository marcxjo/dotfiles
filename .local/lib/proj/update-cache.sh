#!/usr/bin/bash

LIB_DIR=${PROJ_LIB_DIR:-${HOME}/.local/lib/proj}

source ${LIB_DIR}/common.sh

main() {
  local _root_dir=${1}
  local _cache_file=${2}

  find_git_repos "${_root_dir}" > $_cache_file
}

main $SRC_DIR $CACHE_FILE

exit 0
