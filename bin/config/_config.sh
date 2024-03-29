# shellcheck shell=bash
#
# Load Bashdrop global configs.

#######################################
# Define Global Configs
#######################################

readonly CONFIGS=(
  "app"
  "filesystem"
  "git"
  "help"
  "modules"
)

#######################################
# Load Global Configs
#######################################

for CONFIG in "${CONFIGS[@]}"; do
  # shellcheck source=/dev/null
  source "${BIN_DIR}/config/${CONFIG}.sh"
done
