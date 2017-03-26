#!/usr/bin/env zsh -ex

#################
# ZSH Zim       #
#################

if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi
