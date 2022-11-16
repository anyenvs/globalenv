# globalenv

[Globalenv](https://github.com/anyenvs/globalenv) version manager.

Most of the codes are taken from below tools:

* [rbenv](https://github.com/rbenv/rbenv)
* [tfenv](https://github.com/Zordrak/tfenv)

## Installation

1. Check out globalenv into any path (here is `${HOME}/.globalenv`)

  ```sh
  $ git clone https://github.com/anyenvs/globalenv.git ~/.globalenv
  ```

2. Add `~/.globalenv/bin` to your `$PATH` any way you like

  ```sh
  $ echo 'export PATH="$HOME/.globalenv/bin:$PATH"' >> ~/.bash_profile
  ```

## Usage

```
Usage: globalenv <command> [<args>]

Some useful globalenv commands are:
    local       Set or show the local application-specific Helm version
    global      Set or show the global Helm version
    install     Install the specified version of Helm
    uninstall   Uninstall the specified version of Helm
    version     Show the current Helm version and its origin
    versions    List all Helm versions available to globalenv

See `globalenv help <command>' for information on a specific command.
For full documentation, see: https://github.com/anyenvs/globalenv#readme
```

## License

* [globalenv](https://github.com/anyenvs/globalenv)
  * The MIT License
* [rbenv](https://github.com/rbenv/rbenv)
  * The MIT License
* [tfenv](https://github.com/Zordrak/tfenv)
  * The MIT License
