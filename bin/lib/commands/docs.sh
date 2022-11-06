# shellcheck shell=bash
#
# Bashdrop docs command.

#######################################
# Display the Bashdrop docs
# information.
#
# Globals:
#   APP_NAME
#   GIT_REPOSITORY
#   PROJECT_DIR
#
# Outputs:
#   Writes docs information to stdout.
#######################################
function command::docs() {
  local readme_url
  local version

  version="$(git::active_branch --dir="${PROJECT_DIR}")"
  readme_url="${GIT_REPOSITORY}/blob/${version}/README.md"

  console::output --margin-bottom "${APP_NAME} documentation:"

  console::output "$(ansi --bold --white "- Readme")" "${readme_url}"

  console::info --margin-top \
    "Opening the Readme (${version}) to: $(ansi --bold --white "${readme_url}")"

  browser::open "${readme_url}"
}
