Shell Config
=======

# Shell

## Shebang [1](https://en.wikipedia.org/wiki/Shebang_%28Unix%29#Portability)

* For *sh* `#!/usr/bin/env sh`
* For *bash* `#!/usr/bin/env bash`
* For *zsh* `#!/usr/bin/env zsh`

## Which used

`echo $0` [1](http://askubuntu.com/questions/590899/how-to-check-which-shell-am-i-using)

## Switch 

* To *bash* `chsh -s $(which bash)` or `chsh -s /bin/bash`
* To *zsh* `chsh -s $(which zsh)`

# Update

## zsh on OSX [1](http://stackoverflow.com/questions/17648621/how-do-i-update-zsh-to-the-latest-version)

1) Install zsh `brew install --without-etcdir zsh`
2) Add shell path `sudo vim /etc/shells` add to end `/usr/local/bin/zsh`
3) Change default shell `chsh -s /usr/local/bin/zsh`
4) To relead shell settings use `exec zsh` [1](http://unix.stackexchange.com/questions/217905/restart-bash-from-terminal-without-restarting-the-terminal-application-mac)

# VIM

## Debug

* Loading times [1](http://kynan.github.io/blog/2015/07/31/how-to-speed-up-your-vim-startup-time), [2](https://puroh.it/speeding-up-vim/)

http://www.gbonfant.com/blog/speed-up-performance-of-iterm-and-vim