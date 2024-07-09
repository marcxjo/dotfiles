#!/usr/bin/bash

LIB_DIR=${PROJ_LIB_DIR:-${HOME}/.local/lib/proj}

source ${LIB_DIR}/common.sh

try_read_file() {
  local _file=${1}

  cat $_file 2>/dev/null
}

select_dir() {
  local _dir_list_cmd="${@}"

  local _preview_cmd="GIT_DIR={}/.git git ls-files"

  local _proj_dir=$(${_dir_list_cmd} | fzf --preview="${_preview_cmd}")

  echo ${_proj_dir}
}

select_dir_no_cache() {
  local _root_dir=${1}

  select_dir find_git_repos "${_root_dir}"
}

select_dir_with_cache() {
  local _cache_file=${1}

  select_dir cat "${_cache_file}"
}

if [[ -z "${SRC_DIR:-}" ]]; then
  echo "Source directory not specified - no projects to search!"
  exit 1
fi

if [[ ! -f "${CACHE_FILE}" ]]
then
  select_dir_no_cache $SRC_DIR
  exit 0
fi

select_dir_with_cache $CACHE_FILE

exit 0
