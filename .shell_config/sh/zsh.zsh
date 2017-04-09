#!/usr/bin/env zsh -ex

################
# ZSH          #
################

# --------------------------
# bindkey                  #
# --------------------------

# http://stackoverflow.com/questions/12382499/looking-for-altleftarrowkey-solution-in-zsh
bindkey '[C' forward-word
bindkey '[D' backward-word

# --------------------------
# Z folder completion      #
# --------------------------

# https://github.com/rupa/z
Z_PLUGIN="/usr/local/etc/profile.d/z.sh"
if [[ -s "${Z_PLUGIN}" ]]; then
  source "${Z_PLUGIN}"
fi

# --------------------------
# iTerm2 integration       #
# --------------------------

# https://www.iterm2.com/documentation-shell-integration.html
ITERM2_PLUGIN="${HOME}/.iterm2_shell_integration.zsh"
if [[ -s "${ITERM2_PLUGIN}" ]]; then
  source "${ITERM2_PLUGIN}"
fi

# ----------------------
# SSH background color #
# ----------------------

# https://coderwall.com/p/t7a-tq/change-terminal-color-when-ssh-from-os-x
PRODUCTION_ITERM2_PROFILE="PROD"
PRODUCTION_HOST_PATTERN_DEFAULT="foo-bar-(1|2)*|prod-bastion-1"

# Check if default is set for PROD host pattern from secret
# http://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if [ -z ${PRODUCTION_HOST_PATTERN+x} ]; then
	PRODUCTION_HOST_PATTERN=${PRODUCTION_HOST_PATTERN_DEFAULT}
fi

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
            if [[ "$*" =~ ${PRODUCTION_HOST_PATTERN} ]]; then
                tabc ${PRODUCTION_ITERM2_PROFILE}
            else
                tabc Other
            fi
        fi
    fi
    ssh $*
}

compdef _ssh tabc=ssh

alias ssh="colorssh"


# --------------------------
# AWS CLI auto completion  #
# --------------------------

# http://docs.aws.amazon.com/cli/latest/userguide/cli-command-completion.html
AWS_COMPLETE="/usr/local/bin/aws_zsh_completer.sh"
if [[ -s "${AWS_COMPLETE}" ]]; then
  source "${AWS_COMPLETE}"
fi

# -----------------------------
# Show ls after every cd      #
# -----------------------------

# http://stackoverflow.com/questions/3964068/zsh-automatically-run-ls-after-every-cd
function chpwd() {
    emulate -L zsh
    ll
}


# -----------------------------
# Git patch                   #
# -----------------------------

git_patch_1() {	git show "$1" | git apply}
git_patch_2() {	git cherry-pick "$1" && git reset --soft HEAD~1 }
