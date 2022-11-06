# shellcheck shell=bash
#
# Bashdrop self update command.

#######################################
# Update Bashdrop to the latest
# version.
#
# Globals:
#   APP_COMMAND
#   APP_NAME
#   PROJECT_DIR
#
# Outputs:
#   Writes messages to stdout.
#######################################
function command::self_update() {
  local latest_tag

  if ! os::has_installed git; then
    console::error --margin-top --margin-bottom "Git is not installed!"

    # Git download URL.
    local url="https://git-scm.com"
    readonly url

    console::output \
      "$(ansi --bold --white "${APP_NAME}") requires Git to update to the" \
      "latest version. Please installed Git via" \
      "$(ansi --bold --white --underline "${url}")."

    exit 1
  fi

  git::fetch --dir="${PROJECT_DIR}"

  latest_tag="$(git::latest_tag --dir="${PROJECT_DIR}")"

  console::info \
    "[1/1] Updating $(ansi --bold --white "${APP_NAME}")" \
    "to $(ansi --bold --white "${latest_tag}") ..."

  progressbar::start
  progressbar::half
  progressbar::finish --clear

  console::info --overwrite \
    "[1/1] Updating $(ansi --bold --white "${APP_NAME}")" \
    "to $(ansi --bold --white "${latest_tag}") $(ansi --bold --white "[OK]")"

  git::checkout --dir="${PROJECT_DIR}" --branch="${latest_tag}"
}
