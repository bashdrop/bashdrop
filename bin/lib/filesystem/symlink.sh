# shellcheck shell=bash
#
# Bashdrop internal filesystem symlink functions.

#######################################
# Create a Symbolic Link.
#
# Arguments:
#   --original
#   --link
#######################################
function symlink::create() {
  local arguments_list=("link" "original")
  local link
  local original

  while [ $# -gt 0 ]; do
    if [[ "${1}" == *"--"* && "${1}" == *"="* ]]; then
      local argument="${1/--/}"
      IFS='=' read -ra parameter <<< "${argument}"

      if [[ "${arguments_list[*]}" =~ ${parameter[0]} ]]; then
        declare "${parameter[0]}"="${parameter[1]}"
      fi
    fi

    shift
  done

  unset arguments_list

  # If path is working directory, rebuild full path.
  original_file_path="$(filesystem::file_path "${original}")"
  original_file_name="$(filesystem::file_name "${original}")"

  original="${original_file_path}/${original_file_name}"

  # If path is working directory, rebuild full path.
  link_file_path="$(filesystem::file_path "${link}")"
  link_file_name="$(filesystem::file_name "${link}")"

  link="${link_file_path}/${link_file_name}"

  ln -s "${original}" "${link}"
}

#######################################
# Remove the Symbolic Link.
#
# Arguments:
#   Link
#######################################
function symlink::remove() {
  unlink "${1}"
}

#######################################
# Check if the path is a Symbolic Link.
#
# Arguments:
#   Link
#
# Returns:
#   0 if the path is a symlink.
#   1 if the path is not a symlink.
#######################################
function symlink::is_symlink() {
  [[ -L "${1}" ]] && return 0 || return 1
}

#######################################
# Check if the Symbolic Link is valid.
#
# Arguments:
#   Link
#
# Returns:
#   0 if the symlink is valid.
#   1 if the symlink isn't valid.
#######################################
function symlink::is_valid() {
  [[ -e "${1}" ]] && return 0 || return 1
}

#######################################
# Get the target file for the Symbolic
# Link.
#
# Arguments:
#   Link
#
# Outputs:
#   The file name including path.
#######################################
function symlink::target() {
  readlink -f "${1}"
}
