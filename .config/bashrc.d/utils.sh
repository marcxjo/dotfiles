# All-purpose utility functions
# Things I typically use all the darn time

run() {
  setsid -f -- "$@" 0<&- &>/dev/null
}
