# prompt style and colors based on Steve Losh's Prose theme:
# http://github.com/sjl/oh-my-zsh/blob/master/themes/prose.zsh-theme
#
# vcs_info modifications from Bart Trojanowski's zsh prompt:
# http://www.jukie.net/bart/blog/pimping-out-zsh-prompt
#
# git untracked files modification from Brian Carper:
# http://briancarper.net/blog/570/git-info-in-your-zsh-prompt

export VIRTUAL_ENV_DISABLE_PROMPT=1

setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

#use extended color palette if available
if [[ $terminfo[colors] -ge 256 ]]; then
    turquoise="%F{81}"
    orange="%F{166}"
    purple="%F{135}"
    hotpink="%F{161}"
    limegreen="%F{118}"
    grey="%F{239}"
else
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    hotpink="%F{red}"
    limegreen="%F{green}"
    grey="%F{grey}"
fi

# enable VCS systems you use
zstyle ':vcs_info:*' enable git

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
PR_RST="%f"
FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
FMT_ACTION="(%{$limegreen%}%a${PR_RST})"
FMT_UNSTAGED="%{$orange%}●"
FMT_STAGED="%{$limegreen%}●"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '| '%F{yellow}`basename $VIRTUAL_ENV`%f' '
}

function steeef_precmd {
      # check for untracked files or updated submodules, since vcs_info doesn't
      if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
          FMT_BRANCH="| %{$turquoise%}%b%u%c%{$hotpink%}●${PR_RST}"
      else
          FMT_BRANCH="| %{$turquoise%}%b%u%c${PR_RST}"
      fi
      zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "

      vcs_info 'prompt'
}
add-zsh-hook precmd steeef_precmd

PROMPT=$'
[ %? %{$grey%}| %D{%y-%m-%d %H:%M:%S} | %{$purple%}%n%f@%{$orange%}%m%f%{$grey%} $vcs_info_msg_0_$(virtualenv_info)] %{$limegreen%}%~${PR_RST}
❯ '
