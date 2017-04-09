`.`Files
========

Collection of my `.`Files to optimize the cli experience, tinkering and developing software.

This is heavily inspired by the work of the following people:

* [Dominik's](https://github.com/dhabersack/dotfiles)
* [Sebastian's](https://github.com/hypebeast/dotfiles) example.

# TOC

* [shell](.shell_config/README.md)
* [ssh](.ssh/README.md)

# Setup

1. OS X setup following my [guide](https://lony.github.io/post/2016/mac-osx-setup/)
2. Clone repository from [here](https://github.com/lony/dotFiles) into your home
3. Config
    * TBD
        * vim - add section in readme
            * Adjusting the `.shell_config/sh/.all_secret` adding at least a valid Github token
            * Run `./.shell_config/bin/concat_files.py` to compile config files
            * Open vim and run `:PlugInstall` installing set plugins in my `.vimrc` see [VimAwesome.com](http://vimawesome.com/) for more
                * **Hint**: To jump from the CLI to a vim editing mode [as configured](http://nuclearsquid.com/writings/edit-long-commands/) use `ESC v`
        * tmux - add section in readme
            * **Hint**: Interested in `tmux` read [Daniel Miessler's post](https://danielmiessler.com/study/tmux/)

## Todo

* Install

    - [ ] Create bash init script to install Ansible [1](https://github.com/mtchavez/mac-ansible)
    - [ ] Create Ansible script to install
        
        * brew and brew cask
        * Github dependencies (oh-my plugins)
        * Set configuration for OS
        * Set default shell (use config script)
    
    - [ ] Add Ubuntu Linux support
