# Git-specific functions
# Note that these do require some exotic tools, like my custom Git
# extensions and fzf

proj() {
  local -r _workspace_cache="$(git profile projs workspace cache get)"

  [[ -z "$_workspace_cache" ]] &&
    echo "Cache file does not exist" >&2 2>&1 &&
    return 1

  local -r _preview_cmd="GIT_DIR={}/.git git ls-files"
  local -r _repo="$(fzf --prompt='Repository: ' --preview="$_preview_cmd" <"$_workspace_cache")"

  [[ ! "$_repo" ]] &&
    echo "That's it, back to Winnipeg!" &&
    return

  cd "$_repo"
}

pcache() {
  git profile projs workspace default cache update
}

gitroot() {
  if ! proj_root="$(git rev-parse --show-toplevel 2>/dev/null)"; then
    echo "Can't cd - not in a git repository"
    return 1
  fi

  cd "$proj_root"
}
