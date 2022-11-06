# shellcheck shell=bash
#
# Bashdrop internal browser functions.

#######################################
# Open URLs using the default browser
# application.
#
# Arguments:
#   Url
#######################################
function browser::open() {
  open "${1}"
}
