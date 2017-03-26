Shell Config
=======

# Shell

* [bash](https://www.gnu.org/software/bash/)
* [zsh](http://www.zsh.org/)

    * Frameworks

        1. [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
        2. [prezto](https://github.com/zsh-users/prezto)
        3. [zim](https://github.com/Eriner/zim)

* [fish](/etc/shells)

    * Frameworks

        1. [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish)

## Shebang [1](https://en.wikipedia.org/wiki/Shebang_%28Unix%29#Portability)

* For **sh** `#!/usr/bin/env sh`
* For **bash** `#!/usr/bin/env bash`
* For **zsh** `#!/usr/bin/env zsh`
* For **fish** `#!/usr/bin/env fish`

## Used

Check which shell is currently used?

`echo $SHELL` [1](http://askubuntu.com/questions/590899/how-to-check-which-shell-am-i-using), [2](http://stackoverflow.com/questions/9910966/how-to-tell-if-its-using-zsh-or-bash)

## Switch

* To **bash** `chsh -s $(which bash)` or `chsh -s /bin/bash`
* To **zsh** `chsh -s $(which zsh)`
* To **fish** `chsh -s $(which fish)`

## Install/ Update

### zsh on OSX [1](http://stackoverflow.com/questions/17648621/how-do-i-update-zsh-to-the-latest-version)

1. Install zsh `brew install --without-etcdir zsh`
2. Add shell path `sudo vim /etc/shells` add to end `/usr/local/bin/zsh`
3. Change default shell `chsh -s /usr/local/bin/zsh`
4. To reload shell settings use `exec zsh` [1](http://unix.stackexchange.com/questions/217905/restart-bash-from-terminal-without-restarting-the-terminal-application-mac)

### fish on OSX [1](https://hackercodex.com/guide/install-fish-shell-mac-ubuntu)

1. Install fish `brew install fish`
2. Add shell path `echo "/usr/local/bin/fish" | sudo tee -a /etc/shells`
3. Change default shell `chsh -s /usr/local/bin/fish`

# VIM

## Debug

* Loading times [1](http://kynan.github.io/blog/2015/07/31/how-to-speed-up-your-vim-startup-time), [2](https://puroh.it/speeding-up-vim/), [3](http://www.gbonfant.com/blog/speed-up-performance-of-iterm-and-vim)
