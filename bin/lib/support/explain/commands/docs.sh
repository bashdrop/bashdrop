# shellcheck shell=bash
#
# Bashdrop internal explain helper functions.

#######################################
# Display helpful information for
# the docs command.
#
# Globals:
#   APP_COMMAND
#   APP_NAME
#   GIT_REPOSITORY
#
# Outputs:
#   Writes helpful information to
#   stdout.
#######################################
function explain::command_docs() {
  local helpful_tips=(
    "To open the docs URL in your default browser:"
    "${APP_COMMAND} docs"
  )

  explain::display_description \
    "Open ${APP_NAME} documentation in your default browser."

  explain::display_usage "docs"

  explain::display_helpful_tips "${helpful_tips[@]}"

  explain::display_more_information "${GIT_REPOSITORY}#docs-command"
}
