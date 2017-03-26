#!/usr/bin/env zsh -ex

#################
# ZSH PREZTO    #
#################

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Disable: zsh: correct 'sdf' to 'sdef' [nyae]?
unsetopt CORRECT
