#!/usr/bin/env sh -ex


####------------
# ALL SECRETS  -
##############--

# Github
# see https://github.com/settings/tokens
# token needs no scopes
#export HOMEBREW_GITHUB_API_TOKEN=""

# mise https://mise.jdx.dev/getting-started.html
export PATH="$HOME/.local/share/mise/shims:$PATH"

# Go
export GOPATH="$HOME/Go"
# https://stackoverflow.com/questions/36650052/golang-equivalent-of-npm-install-g
export PATH="$PATH:$GOPATH/bin"

# NVM
#export NVM_DIR="$HOME/.nvm"
#[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# Java
#export JAVA_HOME=""

# Spark
#export SPARK_LOCAL_IP=127.0.0.1

# Docker
# export DOCKER_DEFAULT_PLATFORM=linux/amd64

# Kubernetes - add krew package manager
# export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
