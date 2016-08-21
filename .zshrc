################
# GLOBAL       #
################

if [[ -s "${HOME}/.rc" ]]; then
  source "${HOME}/.rc"
fi

################
# ZSH          #
################

# Show ls after every cd
# http://stackoverflow.com/questions/3964068/zsh-automatically-run-ls-after-every-cd
function chpwd() {
    emulate -L zsh
    ll
}

# aws cli auto completion
# http://docs.aws.amazon.com/cli/latest/userguide/cli-command-completion.html
source /usr/local/bin/aws_zsh_completer.sh

# --------------
# Prezto       #
# --------------

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi