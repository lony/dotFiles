#!/usr/bin/env bash -ex

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

SC_SH_BASH="${SC_SH}/bash.bash"
if [[ -s "${SC_SH_BASH}" ]]; then
  source "${SC_SH_BASH}"
fi
