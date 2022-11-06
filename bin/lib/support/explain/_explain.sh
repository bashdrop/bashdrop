# shellcheck shell=bash
#
# Load Bashdrop explain helpers.

#######################################
# Explain Directory
#######################################

readonly EXPLAIN_DIR="${LIB_DIR}/support/explain"

#######################################
# Define Explain Commands
#######################################

readonly EXPLAIN_COMMANDS=(
  "about"
  "docs"
  "help"
  "self_update"
  "usage"
  "version"
)

#######################################
# Load Explain Commands
#######################################

for EXPLAIN_COMMAND in "${EXPLAIN_COMMANDS[@]}"; do
  # shellcheck source=/dev/null
  source "${EXPLAIN_DIR}/commands/${EXPLAIN_COMMAND}.sh"
done

#######################################
# Define Explain Helpers
#######################################

readonly EXPLAIN_HELPERS=(
  "display_sections"
)

#######################################
# Load Explain Helpers
#######################################

for EXPLAIN_HELPER in "${EXPLAIN_HELPERS[@]}"; do
  # shellcheck source=/dev/null
  source "${EXPLAIN_DIR}/${EXPLAIN_HELPER}.sh"
done
