`.`Files
========

[![Build Status](https://travis-ci.org/lony/dotFiles.svg?branch=master)](https://travis-ci.org/lony/dotFiles)

This repository contains my `.`Files an [Ansible](https://en.wikipedia.org/w/index.php?oldid=803771758) playbook and a custom Python script for deployment.

![Sample cli setup](image.png)

# Usage

1. Run `sh -c "$(curl -sSL https://raw.githubusercontent.com/lony/dotFiles/master/setup.sh)"`
  * Executes setup script
  * Download repository to home folder
  * Install ansible prerequisites
  * Run Ansible
2. Customize [ansible/roles/dotfiles/src/bash_zsh/all_secret.sh](ansible/roles/dotfiles/src/bash_zsh/all_secret-example.sh) and maybe [.ssh/config](ansible/roles/dotfiles/src/.ssh/config) (see [SSH guide](https://lony.github.io/post/2017/cli-commands/#secure-shell-command-ssh))
3. Execute `./setup.sh` again
4. Switch repo back `git remote set-url origin git@github.com:lony/dotFiles.git`
5. Generate SSH key in `/Users/<home>/.ssh` using `ssh-keygen -t rsa -b 4096 -C "<YOUR@EMAIL.COM>" -N ""`
6. Add public SSH key to Github [https://github.com/settings/keys](https://github.com/settings/keys)

# Feature

* [x] Setup script to prepare Ansible
* [x] [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) setup
* [x] dotfiles setup, optimizations
* [x] .gitconfig
* [x] vim setup incl. [vim-plug](https://github.com/junegunn/vim-plug) + plugins
* [x] tmux setup incl. [tpm](https://github.com/tmux-plugins/tpm) + plugins
* [x] Sublime setup
* [x] Beyond Compare config
* [x] Python simple setup
* [x] OSX [Homebrew](https://brew.sh/) setup
* [x] OSX [Homebrew Cask](https://caskroom.github.io/) setup
* [x] OSX Homebrew cleanup
* [x] OSX cli configuration see [this](https://lony.github.io/post/2016/mac-osx-setup/#user-interface)
* [x] OSX Dock configuration using [dockutil](https://github.com/kcrawford/dockutil)
* [x] OSX Apple store installation
* [x] OSX iTerm2 configuration see [here](http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/)
* [x] OSX file associations using [duti](https://github.com/moretension/duti)
* [ ] OSX configure [loginitems](https://github.com/OJFord/loginitems)
* [ ] OSX configure [display arrangement](https://github.com/jakehilborn/displayplacer)
* [ ] OSX system configuration scutil see [here](http://osxdaily.com/2012/10/24/set-the-hostname-computer-name-and-bonjour-name-separately-in-os-x/)
* [ ] OSX Hardening https://blog.bejarano.io/hardening-macos.html
* [x] VSCode config setup
* [x] VSCode install extensions
* [x] [Testing with Travis CI](https://github.com/geerlingguy/mac-dev-playbook/blob/master/.travis.yml) support
* [ ] Testing using Packer to build image see [this](https://nickcharlton.net/posts/automating-macos-using-ansible.html)
* [ ] Testing with local VirtualBox see [this](https://github.com/geerlingguy/macos-virtualbox-vm) and [this](http://tobiwashere.de/2017/10/virtualbox-how-to-create-a-macos-high-sierra-vm-to-run-on-a-mac-host-system/)
* [x] Ansible installation for OSX
* [x] Ansible installation for Linux
* [ ] Ansible installation for Windows [really?]

# Architecture

1. The [setup.sh](setup.sh) installs OS specific Ansible prequesites and starts Ansible
2. Ansible has multiple [roles](ansible/site.yml) which each are triggered
3. The dotfile role contains a [Python script](ansible/roles/dotfiles/bin/bootstrap.py) which creates shell scripts for bash, zsh and fish

# Structure

```
❯ tree  -L 5 (custom)
.
├── README.md                     - This readme
├── ansible
│   ├── README.md                 - Ansible links
│   ├── roles
│   │   ├── dotfiles              - First role for dotfiles
│   │   │   ├── bin
│   │   │   │   └── bootstrap.py  - Custom Python script
│   │   │   ├── src               - Dotfiles
│   │   │   └── tasks
│   │   │       └── main.yml      - Task executed by Ansible
│   │   ├── homebrew
│   │   │   ├── tasks
│   │   │   └── vars
│   │   │       └── main.yml      - Variables used by Ansible
│   │   ├── homebrew_cleanup
│   │   ├── python
│   │   ├── tmux
│   │   ├── vim
│   │   └── zsh_oh-my-zsh
│   └── site.yml                  - Ansible playbook definition
└── setup.sh                      - Script to prepare OS for Ansible
```

# Testing

* Amazon Linux
  * Go into `~/dotFiles`
  * `docker pull amazonlinux`
  * `DIR=/root/dotFiles; docker run -it --mount src="$(pwd)",target=$DIR,type=bind --rm amazonlinux bash -c "cd $DIR; ./setup.sh; exec \"\$0\""`

# Thanks

This is heavily inspired by the work of the following people:

* [Dominik's](https://github.com/dhabersack/dotfiles) - basic idea for bash, zsh, vim and tmux
* Christopher - vim plugins
* [Michael](https://github.com/ludwigm) - cli tooling e.g. httpie, jq
* [Sebastian's](https://github.com/hypebeast/dotfiles) - homebrew setup, tmux enhancing
* [Florian](https://github.com/floschnell) - fish support
* [Jeff's](https://github.com/geerlingguy/mac-dev-playbook) - Ansible deployment, testing, mas
* [Chavez's](https://github.com/mtchavez/mac-ansible) - Ansible bootstrapping and vim, tmux enhanced setup
* [Richard's](https://github.com/ricbra/mac-dev-playbook) - Dock configuration
* [Fotis's](https://github.com/fgimian/macbuild) - File associations
