<h4 align="center">
  Bashdrop a Bash micro-framework!
</h4>

<p align="center">
  <a href="#about">About</a> •
  <a href="#disclaimer">Disclaimer</a> •
  <a href="#getting-started">Getting Started</a> •
  <a href="#how-to-use">How To Use</a> •
  <a href="#credits">Credits</a> •
  <a href="#license">License</a>
</p>

## About

Bashdrop is a micro-framework that provides a starting point for your console application.

## Disclaimer

> **Note**
> : This project is a **work-in-progress**. Code and documentation are currently under development and are subject to change.

## Getting Started

GitHub offers a simple approach to generating a new repository with the same directory structure and files as the **Bashdrop** repository. You can click Use this template button or alternatively follow the steps in GitHub [Creating a repository from a template](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template) for a step by step guide.

## How To Use

### Bootstrap the App

The entry point to the Bashdrop Shell Script is `bin/bashdrop`. This will trigger the `main` function, which is located in `bin/bootstrap/app.sh`. There is an alias shell script for this file in the root directory of the project, called `app`

### Dependencies Manager

Files prefixed with an underscore will source Shell files. Consider these files as Shell file importers. The `_lib.sh` will source third-party dependencies and other Shell file importers. Importers include a read-only array of dependencies within their domain e.g. the commands importer which is located in `bin/lib/commands/_commands.sh`

```sh
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

## Credits

This software uses the following open source packages:

- [ANSI Code Generator](https://github.com/fidian/ansi)

## License

The MIT License (MIT). Please see [License File](LICENSE) for more information.
