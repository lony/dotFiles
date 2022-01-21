#!/usr/bin/env sh -ex


################
# ALL          #
################

# --------------
# EXPORTS     #
# --------------

# Locale
# List all: locale -a
# https://pubs.opengroup.org/onlinepubs/7908799/xbd/envvar.html
# https://stackoverflow.com/questions/30479607/explain-the-effects-of-export-lang-lc-ctype-lc-all
# en
export LANG="en_GB:en"
export LC_CTYPE="en_GB.UTF-8"
export LC_MESSAGES="en_GB.UTF-8"
# de
export LC_COLLATE="de_DE.UTF-8"
export LC_MONETARY="de_DE.UTF-8"
export LC_NUMERIC="de_DE.UTF-8"
export LC_TIME="de_DE.UTF-8"

# Prompt
export SUDO_PS1='\[\033[01m\][ \[\033[01;31m\]\u@\h \[\033[00m\]\[\033[01m\]] \[\033[01;32m\]\w\[\033[00m\]\n\[\033[01;31m\]$\[\033[00m\]> '

# List
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# PIP
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE="${HOME}/.pip/cache"

# --------------
# ALIASES     #
# --------------

# List
alias ls='ls -Fh'
alias l='ls -a'
alias ll='ls -la'
alias lsize='du -shc *'

# Delete
alias rm='rm -i'

# Grep
alias grep='grep --color'

# Python
alias p='python'

# Git
alias ga='git add'
alias gb='git branch'
alias gc='git checkout'
alias gco='git commit'
alias gm='git merge'
alias gs='git status'
alias gss='git status -s'
# http://stackoverflow.com/questions/19298600/tag-already-exists-in-the-remote-error-after-recreating-the-git-tag
# http://stackoverflow.com/questions/18308535/automatic-prune-with-git-fetch-or-pull
alias gp='git pull && git fetch --prune --tags'
alias gpu='git push -u && git push origin --tags'
alias gd='git diff'
# https://coderwall.com/p/euwpig/a-better-git-log
# https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History
# https://git-scm.com/docs/git-log/2.9.1
# https://git-scm.com/docs/pretty-formats
# https://stackoverflow.com/questions/1057564/pretty-git-branch-graphs
# https://stackoverflow.com/questions/24604052/truncating-commit-messages
alias gl='git log --graph --pretty=format:"%C(yellow)%h%Creset%C(auto)%d%Creset %<(45,trunc)%s" --abbrev-commit'
alias gll='git log --graph --pretty=format:"%C(yellow)%h%Creset%C(auto)%d%Creset %<(45,trunc)%s %C(cyan)(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias glll='git log --graph --pretty=format:"%C(yellow)%h%Creset%C(auto)%d%Creset %C(cyan)(%cr) %C(bold blue)<%an>%Creset %n %B" --abbrev-commit'
alias gllll='gl -p'
# http://stackoverflow.com/questions/673407/how-do-i-clear-my-local-working-directory-in-git
# http://stackoverflow.com/questions/52704/how-do-you-discard-unstaged-changes-in-git
# https://git-scm.com/docs/git-clean
# http://stackoverflow.com/questions/1628088/reset-local-repository-branch-to-be-just-like-remote-repository-head
# http://stackoverflow.com/questions/1593051/how-to-programmatically-determine-the-current-checked-out-git-branch
alias git_clean_fetch='git fetch origin && branch_name=$(git symbolic-ref -q HEAD) && branch_name=${branch_name##refs/heads/} && branch_name=${branch_name:-HEAD} && git reset --hard origin/$branch_name && git checkout -- . && git clean -df'
alias git_clean_branch='git for-each-ref --format '"'"'%(refname:short)'"'"' refs/heads | grep -v '"'"'\*\|master\|develop'"'"' | xargs git branch -D'

# Vagrant
alias vgu='vagrant destroy -f && vagrant up'

# IntelliJ
alias idea='/usr/local/bin/idea'

# Kubernetes
alias k='kubectl'

# AWS cli
alias awsume=". awsume"

# --------------
# EDITOR       #
# --------------

# http://stackoverflow.com/questions/2596805/how-do-i-make-git-use-the-editor-of-my-choice-for-commits
export VISUAL=vim
export EDITOR="$VISUAL"

alias vi="$VISUAL"
