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
