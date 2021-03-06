# cmd del hc-siderun subcommand implementation

function _sr_cmd_del {
  local _SR_C_DIR="${_SR_WORK_DIR}/${_SR_O_CLUSTER}"
  if [ ! -d "${_SR_C_DIR}" ]; then
    _sr_log "'${_SR_C_DIR}' does not exist, nothing to do"
    return
  fi

  _sr_log "deleting ${_SR_C_DIR}"

  rm "${_SR_C_DIR}/cluster.screenrc" > /dev/null 2>&1 || true

  find "${_SR_C_DIR}" -iname '*.log' -delete > /dev/null 2>&1 || true

  # make cleaning up work dirs a little safer (rm -Rf * yay)
  for __NODE in $(ls "${_SR_C_DIR}"); do
    local __P="${_SR_C_DIR}/${__NODE}"
    if [[ ${__NODE} == "${_SR_MAGIC}"* ]] && [ -d "${__P}" ]; then
      rm -Rf "${__P}"
    fi
  done

  rmdir "${_SR_C_DIR}"
}
