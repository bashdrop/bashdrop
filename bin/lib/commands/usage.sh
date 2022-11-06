# shellcheck shell=bash
#
# Bashdrop usage command.

#######################################
# Display the Bashdrop usage options.
#
# Global:
#   APP_NAME
#   APP_TAGLINE
#   APP_COMMAND
#   GIT_REPOSITORY
#
# Outputs:
#   Writes usage options to stdout.
#######################################
function command::usage() {
  local commands=(
    "about"
    "docs"
    "self-update"
    "version"
  )

  local descriptions=(
    "Shows a short information about ${APP_NAME}."
    "Open ${APP_NAME} documentation in the browser."
    "Update ${APP_NAME} to the latest version."
    "Display ${APP_NAME} installed version."
  )

  for index in "${!commands[@]}"; do
    help::add_command \
      --command="${commands[index]}" \
      --description="${descriptions[index]}"
  done

  help::title "${APP_NAME}"

  help::tagline "${APP_TAGLINE}"

  help::contribute \
    --package_name="${APP_NAME}" \
    --package_url="${GIT_REPOSITORY}"

  help::display_usage \
    --command_name="${APP_COMMAND}" \
    --has-arguments \
    --has-options

  help::display_commands

  help::display_useful_tips \
    --command_name="${APP_COMMAND}"
}
