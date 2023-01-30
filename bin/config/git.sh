# shellcheck shell=bash
#
# Define Bashdrop global Git constants.

#######################################
# Git Regex Pattern
#######################################

readonly GIT_REGEX="^(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/(.+).git$"
export GIT_REGEX

#######################################
# Git Repository
#######################################

readonly GIT_REPOSITORY="https://github.com/bashdrop/bashdrop"
export GIT_REPOSITORY
