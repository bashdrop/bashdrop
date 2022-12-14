# shellcheck shell=bash
#
# Load Bashdrop utilities.

#######################################
# Define Utilities
#######################################

readonly UTILITIES=(
  "browser"
  "git"
  "os"
)

#######################################
# Load Utilities
#######################################

for UTILITY in "${UTILITIES[@]}"; do
  # shellcheck source=/dev/null
  source "${LIB_DIR}/utils/${UTILITY}.sh"
done
