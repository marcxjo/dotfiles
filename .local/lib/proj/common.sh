find_git_repos() {
  local _root_dir=${1}

  find "${_root_dir}" -type d -name ".git" -exec dirname {} \;
}

SRC_DIR=${PROJ_SRC_DIR:-${HOME}/.local/src}
CACHE_FILE=${PROJ_CACHE_FILE:-${SRC_DIR}/.proj_cache}
