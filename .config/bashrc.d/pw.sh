# pw - Manage multiple password stores with Unix `pass`

pw() {
  local -r _config_root="${PW_CONFIG_ROOT:-${HOME}/.config/pass}"
  local -r _pw_store_dir="${_config_root}/${1}"

  shift 1

  env PASSWORD_STORE_DIR="${_pw_store_dir}" pass "${@}"
}
