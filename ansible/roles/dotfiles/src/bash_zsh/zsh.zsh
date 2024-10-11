#!/usr/bin/env zsh -ex

################
# ZSH          #
################

# --------------------------
# history                  #
# --------------------------

# https://ryantoddgarza.com/a-better-zsh-history-pt1
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE

# --------------------------
# bindkey                  #
# --------------------------

# Back/Forward word
#
# iTerm2
# http://stackoverflow.com/questions/12382499/looking-for-altleftarrowkey-solution-in-zsh
bindkey '[C' forward-word
bindkey '[D' backward-word
# tmux
# http://stackoverflow.com/questions/12382499/looking-for-altleftarrowkey-solution-in-zsh
#bindkey "^[[1;3C" forward-word
#bindkey "^[[1;3D" backward-word

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

# -------------------------------------------------------------
# zsh completions https://docs.brew.sh/Shell-Completion #
# -------------------------------------------------------------

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi
