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
# COLORS       #
# --------------

# enable colors
autoload -U colors && colors

# --------------
# HISTORY      #
# --------------

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt SHARE_HISTORY        # share history across sessions
setopt HIST_IGNORE_SPACE    # commands starting w/ a space don't go into 
setopt HIST_IGNORE_DUPS     # preventing duplicate lines in the history
