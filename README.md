<p align="center">
  <a href="https://github.com/bashdrop/bashdrop">
    <img src="./images/banner.png" alt="banner" width="100%">
  </a>
</p>

<h4 align="center">
  Bashdrop is a Bash micro-framework!
</h4>

<p align="center">
  <a href="#about">About</a> •
  <a href="#disclaimer">Disclaimer</a> •
  <a href="#getting-started">Getting Started</a> •
  <a href="#how-to-use">How To Use</a> •
  <a href="#style-guidelines">Style Guidelines</a> •
  <a href="#credits">Credits</a> •
  <a href="#license">License</a>
</p>

## About

Bashdrop is a micro-framework that provides a starting point for your console application.

## Disclaimer

> **Note**  
> This project is a **work-in-progress**. Code and documentation are currently under development and are subject to change.

## Getting Started

GitHub offers a simple approach to generating a new repository with the same directory structure and files as the **Bashdrop** repository. You can click Use this template button or alternatively follow the steps in GitHub [Creating a repository from a template](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template) for a step by step guide.

## How To Use

Documentation on the architectural concepts has been outlined below for you to get started:

### Run Console App

To run the Bashdrop console app, you can run the `app` script:

```bash
$_ ./app
```

The `app` script will show a list of available commands. To invoke a command, you can provide your command name and the required arguments to the `app` script:

```bash
$_ ./app command argument
```

### Bootstrap the App

The entry point to the Bashdrop Shell Script is `bin/bashdrop`. This will trigger the `main` function, which is located in `bin/bootstrap/app.sh`. There is an alias shell script for this file in the root directory of the project, called `app`

### Dependencies Manager

Files prefixed with an underscore will source Shell files. Consider these files as Shell file importers. The `_lib.sh` will source third-party dependencies and other Shell file importers. Importers include a read-only array of dependencies within their domain e.g. the commands importer which is located in `bin/lib/commands/_commands.sh`

```sh
# bin/lib/_lib.sh

readonly DEPENDENCIES=(
  "commands"
  "console"
  "core"
  "filesystem"
  "support"
  "utils"
)

for DEPENDENCY in "${DEPENDENCIES[@]}"; do
  # shellcheck source=/dev/null
  source "${LIB_DIR}/${DEPENDENCY}/_${DEPENDENCY}.sh"
done
```

### Retrieving Environment Variables 

All of the environment variables listed in the `.env` file will be loaded into your console application. You can use the `dotenv::get` function to retrieve values from these variables.

```sh
APP_NAME="$(dotenv::get APP_NAME --default=Bashdrop)"
```

The second argument passed to the `dotenv::get` function is the "default value". This value will be returned if no environment variable exists for the given key.

### Configuration

##### Creating Configuration File

You can create a config file in the `bin/config` directory. The recommended naming convention for global configuration variable names is to use upper case and snake case.

```sh
export APP_NAME="Bashdrop"
```

You will need to register your config file in the `_config.sh` Shell file importer.

```sh
# bin/lib/config/_config.sh

readonly CONFIGS=(
  "app"
  "filesystem"
  "git"
  "help"
  "modules"
)
```

##### Accessing Configuration Value

The global configuration values may be accessed providing the variable name with the `"${}"` syntax.

```sh
"${APP_NAME}"
```

### Writing Commands

You can build your own custom commands. Commands are typically stored in the `bin/lib/commands` directory. You will need to register your command file in the `_commands.sh` Shell file importer.

```sh
# bin/lib/commands/_commands.sh

readonly COMMANDS=(
  "about"
  "docs"
  "help"
  "self_update"
  "usage"
  "version"
)

```

##### Command Structure

Let's take a look at an example command.

```sh
# shellcheck shell=bash
#
# Bashdrop example command.

#######################################
# An example command.
#
# Globals:
#   APP_NAME
#
# Arguments:
#   User input
#
# Outputs:
#   Writes messages to stdout.
#
# Returns:
#   1 if user provides invalid
#   combination of arguments.
#######################################
function command::example() {
  local message=$*

  console::output "${message}"
}
```

We can invoke our command as follows:

```bash
$_ ./app example Hello
Hello
```

To pass arguments to a Bash function, add the parameters after the function call separated by spaces. The table below outlines the available options when working with bash function arguments.

|   Argument   	| Role                                                                                                                                 	|
|:------------:	|--------------------------------------------------------------------------------------------------------------------------------------	|
|      $0      	| Reserves the function's name when defined in the terminal. When defined in a bash script, $0 returns the script's name and location. 	|
| $1, $2, etc. 	| Corresponds to the argument's position after the function name.                                                                      	|
|      $#      	| Holds the count of positional arguments passed to the function.                                                                      	|
|   $@ and $*  	| Hold the positional arguments list and function the same when used this way.                                                         	|
|     "$@"     	| Expands the list to separate strings. For example "$1", "$2", etc.                                                                   	|
|     "$*"     	| Expands the list into a single string, separating parameters with a space. For example "$1 $2" etc.                                  	|

Unfortunately, Bash functions do not support named parameters. Users will need to provide the command's arguments in the exact order for the function to correspond the argument's position. 

If your command as optional arguments or options, invoking the command can be challenging for users. Bashdrop solves this problem with additional code added to a Bash function.

```sh
# shellcheck shell=bash
#
# Bashdrop example command.

#######################################
# An example command.
# 
# Globals:
#   APP_NAME
#
# Arguments:
#   User input
#
# Outputs:
#   Writes messages to stdout.
#
# Returns:
#   1 if user provides invalid
#   combination of arguments.
#######################################
function command::example() {
  # Provide list of excepted options to array.
  local options_list=("directory")
  local directory
  local file=$*

  # This code will match the corresponding options of the provided user arguments 
  while [ $# -gt 0 ]; do
    if [[ $1 == *"--"* && $1 == *"="* ]]; then
      local option="${1/--/}"
      IFS='=' read -ra parameter <<< "${option}"

      if [[ "${options_list[*]}" =~ ${parameter[0]} ]]; then
        file="${file/--${option}/}"
        declare "${parameter[0]//-/_}"="${parameter[1]}"
      fi
    fi

    shift
  done

  unset options_list

  console::output "${directory}/${file}"
}
```

Options, like arguments, are another form of user input. Options are prefixed by two hyphens (--) when they are provided via the command line.

We can invoke our command as follows:

```bash
$_ ./app example example.txt --directory=/app
/app/example.txt

# You can change the order of the arguments
$_ ./app example --directory=/app example.txt
/app/example.txt
```

## Style Guidelines

Bashdrop uses the [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html).

## Credits

This software uses the following open-source packages:

- [ANSI Code Generator](https://github.com/fidian/ansi)

## License

The MIT License (MIT). Please see [License File](LICENSE) for more information.

---

<p align="center">
  <a href="https://supportukrainenow.org" target="_blank">
    <img src="./images/standwithukraine.png" alt="#StandWithUkraine" width="100%">
  </a>
</p>
