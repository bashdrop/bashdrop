# shellcheck shell=bash
#
# Bashdrop version command.

#######################################
# Display the application Git version
# or the active branch.
#
# Globals:
#   PROJECT_DIR
#
# Outputs:
#   Writes messages to stdout.
#######################################
function command::version() {
  console::output "$(git::active_branch --dir="${PROJECT_DIR}")"
}

#######################################
# Display the helpful information for
# the version command.
#
# Globals:
#   APP_COMMAND
#   APP_NAME
#   GIT_REPOSITORY
#
# Outputs:
#   Writes messages to stdout.
#######################################
function explain::version() {
  local helpful_tips=(
    "The version command displays the Git checked out tag or branch:"
    "${APP_COMMAND} version"
  )

  explain::display_description \
    "Display ${APP_NAME} installed version."
  explain::display_usage "version"
  explain::display_helpful_tips "${helpful_tips[@]}"
  explain::display_more_information "${GIT_REPOSITORY}#version-command"
}
