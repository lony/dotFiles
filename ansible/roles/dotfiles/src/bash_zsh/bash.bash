#!/usr/bin/env bash -ex


################
# Bash         #
################

# --------------
# Prompt      #
# --------------

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1="\[\033[01m\][ \[\033[01;34m\]\u@\h \[\033[00m\]\[\033[01m\]] \[\033[01;32m\]\w\[\033[00m\]\[\033[33m\]\$(parse_git_branch)\[\033[00m\] \n\[\033[01;34m\]$\[\033[00m\]> "

# -----------------------------
# Show ls after every cd      #
# -----------------------------

# http://unix.stackexchange.com/questions/20396/make-cd-automatically-ls
function chpwd() {
    cd "$@" && ll;
}
alias cd='chpwd'


# -----------------------------
# AWS CLI auto completion     #
# -----------------------------

# http://docs.aws.amazon.com/cli/latest/userguide/cli-command-completion.html
AWS_COMPLETE="/usr/local/bin/aws_completer"
if [[ -s "${AWS_COMPLETE}" ]]; then
  complete -C "${AWS_COMPLETE}" aws
fi

# -----------------------------
# Git patch                   #
# -----------------------------

function git_patch_1 {
	git show "$1" | git apply
}
function git_patch_2 {
	git cherry-pick "$1" && git reset --soft HEAD~1
}
