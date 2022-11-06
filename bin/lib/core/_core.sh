# shellcheck shell=bash
#
# Load Bashdrop core dependencies.

#######################################
# Define Core Dependencies
#######################################

readonly CORE_DEPENDENCIES=(
  "bashdrop"
)

#######################################
# Load Core Dependencies
#######################################

for CORE in "${CORE_DEPENDENCIES[@]}"; do
  # shellcheck source=/dev/null
  source "${LIB_DIR}/core/${CORE}.sh"
done
