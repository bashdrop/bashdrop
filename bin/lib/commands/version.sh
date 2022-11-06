# shellcheck shell=bash
#
# Bashdrop version command.

#######################################
# Display the Bashdrop version.
#
# Globals:
#   PROJECT_DIR
#
# Outputs:
#   Writes current version to stdout.
#######################################
function command::version() {
  console::output "$(git::active_branch --dir="${PROJECT_DIR}")"
}
