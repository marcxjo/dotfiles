# gethub
# A custom Git cloning tool that allows a simpler syntax for known providers

join_array() {
  local -r _delimiter="$1"
  local -ra _arr=("${@:2}")

  (
    IFS="$_delimiter"
    echo "${_arr[*]}"
  )
}

build_path() {
  local -ar _segments=("$@")

  # HACK - overwriting a global variable with a local one
  # Any cleaner way I can find to do this is also unnecessarily verbose
  join_array '/' "${_segments[@]}"
}

get_index() {
  local -r _needle="$1"

  [[ -z "$_needle" ]] &&
    echo -1 &&
    return 1

  local -r _haystack=("${@:2}")

  [[ ${#_haystack[@]} -le 0 ]] &&
    echo -1 &&
    return 1

  for x in "${!_haystack[@]}"; do
    if [[ "${_haystack[$x]}" = "$_needle" ]]; then
      echo "$x"
      return
    fi
  done

  echo -1
  return 1
}

gethub() {
  local -ri _opts_separator_index=$(get_index '--' "$@")
  local -ri _opts_offset=$((_opts_separator_index + 1))

  local -a _git_clone_opts

  if [[ $_opts_separator_index -gt 0 ]]; then
    _git_clone_opts=("${@:1:${_opts_offset}}")
  fi

  shift $_opts_offset

  [[ -r ${HOME}/.config/gethub/providers ]] &&
    . "${HOME}/.config/gethub/providers"

  local -r _repo_host="${GIT_PROVIDERS[$1]:-$1}"
  local -ra _repo_path_segments=("${@:2}")
  local -r _repo_path_root=$(git profile projs workspace root get)

  GIT_PCLONE_SRC_ROOT="$_repo_path_root" git profile projs workspace pclone "${_git_clone_opts[@]}" "${_repo_host}" "${_repo_path_segments[@]}"
}
