################
# GLOBAL       #
################

if [[ -s "${HOME}/.rc" ]]; then
  source "${HOME}/.rc"
fi

################
# BASH         #
################

# Prompt
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1="\[\033[01m\][ \[\033[01;34m\]\u@\h \[\033[00m\]\[\033[01m\]] \[\033[01;32m\]\w\[\033[00m\]\[\033[33m\]\$(parse_git_branch)\[\033[00m\] \n\[\033[01;34m\]$\[\033[00m\]> "

# Show ls after every cd
# http://unix.stackexchange.com/questions/20396/make-cd-automatically-ls
function chpwd() {
    cd "$@" && ll;
}
alias cd='chpwd'

# aws cli auto completion
# http://docs.aws.amazon.com/cli/latest/userguide/cli-command-completion.html
complete -C '/usr/local/bin/aws_completer' aws