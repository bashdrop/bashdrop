#!/usr/bin/env bash
#
# Alias shell script for ./bin/bashdrop.

set -e

#######################################
# Prevent Sourcing
#
# Firstly, we need to ensure Bashdrop
# is executed in a new shell process.
#######################################

if [[ ${BASH_SOURCE[0]} != "$0" ]]; then
  echo >&2 "ERROR: \`Bashdrop\` cannot be sourced."

  exit 1
fi

#######################################
# Define Global Constant
#
# Secondly, we determine the Bashdrop
# directory.
#######################################

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly CURRENT_DIR

#######################################
# Run The Application
#
# Finally, we execute the Bashdrop
# application.
#######################################

exec "${CURRENT_DIR}/bin/bashdrop" "$@"
