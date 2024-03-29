# shellcheck shell=bash
#
# Bashdrop Command Line Interface (CLI).

#######################################
# The Bashdrop CLI.
#
# Globals:
#   APP_COMMAND
#   MODULES_LIST
#
# Arguments:
#   User input
#
# Outputs:
#   Writes messages to stdout.
#
# Returns:
#   1 if the command is not supported.
#######################################
function bashdrop::console() {
  if [ $# == 0 ]; then
    command::usage

    exit 0
  fi

  for argument in "$@"; do
    shift
    case "${argument}" in
      -v|--version)
        command::version
        break;;
      -h|--help)
        command::usage
        break;;
      *)
        local cli_command="command::${argument//-/_}"

        # If the command does not exist, try loading a module.
        if [[ $( type -t "${cli_command}" ) != function ]]; then
          module="$(cut -d':' -f1 <<< "${argument}")"
          condition="(^|[[:space:]])${module}($|[[:space:]])"

          if [[ "${MODULES_LIST[*]}" =~ ${condition} ]]; then
            module::load "${module}"
            cli_command="${argument//:/::command_}"
            cli_command="${cli_command//-/_}"
          fi
        fi

        if [[ $( type -t "${cli_command}" ) != function ]]; then
          console::error --margin-top --margin-bottom \
            "Command $(ansi --bold --white "${argument}" ) is not supported."

          console::output \
            "To view a list of all available commands use the following:" \
            "$(ansi --bold --white "${APP_COMMAND} --help")"

          exit 1
        fi

        # Execute the Bashdrop command.
        "${cli_command}" "$@"

        break;;
    esac
  done
}
