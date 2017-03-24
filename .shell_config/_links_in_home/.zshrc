#!/usr/bin/env zsh -ex

SC_SH="${HOME}/.shell_config/sh"

################
# GLOBAL       #
################

SC_SH_ALL="${SC_SH}/all.sh"
if [[ -s "${SC_SH_ALL}" ]]; then
  source "${SC_SH_ALL}"
fi

SC_SH_ALL_SECRET="${SC_SH}/all_secret.sh"
if [[ -s "${SC_SH_ALL_SECRET}" ]]; then
  source "${SC_SH_ALL_SECRET}"
fi

################
# BASH         #
################

# if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
#   source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
# fi

SC_SH_ZSH_OHMY="${SC_SH}/zsh_oh-my.zsh"
if [[ -s "${SC_SH_ZSH_OHMY}" ]]; then
  source "${SC_SH_ZSH_OHMY}"
fi

SC_SH_BASH="${SC_SH}/zsh.zsh"
if [[ -s "${SC_SH_BASH}" ]]; then
  source "${SC_SH_BASH}"
fi
