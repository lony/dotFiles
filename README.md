# `.`Files

Collection of my `.`Files folowing [Dominik's](https://github.com/dhabersack/dotfiles) example.


## Installation
Checkout the repository into your home folder. Keep in mind your existing configuration files could be *overwritten*! (see Todo)

## Configuration
To let alias and exports work with `zsh` and `bash` the `.rc` is loaded in both. It contains all agnostic configurations. To avoid commiting secrets a `.rc_secret` is sourced inside the `.rc`. 

## Includes

* Bash and ZSH aliases
* Vim configuration
* zprezto for ZSH
* SSH tweaks

## Todo

- [ ] Test keybinding (eg. jump words, open prompt in editor, etc)
- [ ] Move git branch info one line up
- [ ] tmux support
- [ ] Ubuntu support
- [ ] Change method of installation (eg. Ansible, extract red prompt, ask for configuration, link prezto)
