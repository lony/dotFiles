################
# GLOBAL       #
################

if [[ -s "${HOME}/.rc" ]]; then
  source "${HOME}/.rc"
fi

################
# ZSH          #
################

# --------------
# Prezto       #
# --------------

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# --------------
# cd + ls      #
# --------------

# Show ls after every cd
# http://stackoverflow.com/questions/3964068/zsh-automatically-run-ls-after-every-cd
function chpwd() {
    emulate -L zsh
    ll
}

# ----------------------
# SSH background color #
# ----------------------

function tabc() {
    NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi
    # if you have trouble with this, change
    # "Default" to the name of your default theme
    echo -e "\033]50;SetProfile=$NAME\a"
}

function tab-reset() {
    NAME="Default"
    echo -e "\033]50;SetProfile=$NAME\a"
}

# Needs a iTerm2 profile Default and PROD setup before.
# The PROD one with the settings #460400 for the tab color in the color tab.
function colorssh() {
    if [ -n ${TERM_PROGRAM+x} ]; then
        if [[ -n "$ITERM_SESSION_ID" ]]; then
            trap "tab-reset" INT EXIT
            if [[ "$*" =~ "foo-bar-(1|2)*|prod-bastion-1" ]]; then
                tabc PROD
            else
                tabc Other
            fi
        fi
    fi
    ssh $*
}

compdef _ssh tabc=ssh

alias ssh="colorssh"

# ------------------
# AWS autocomplete #
# ------------------

# aws cli auto completion
# http://docs.aws.amazon.com/cli/latest/userguide/cli-command-completion.html
source /usr/local/bin/aws_zsh_completer.sh
