#!/usr/bin/env sh
#
# Script prepares operating system with foundation to run Ansible
# Tools installed depend on operating system and environment

if [ "$TRAVIS" = "true" ]; then
  set -ex
elif [ "$CORPORATE" = "true" ]; then
  set -x
else
  set -e
fi


## Config
#

GIT_REPO_URL="https://github.com/lony/dotFiles.git"
GIT_REPO_BRANCH="main"
GIT_CLONE_FOLDER="$HOME/dotFiles"
ANSIBLE_PLAYBOOK_PATH="ansible/site.yml"
ANSIBLE_PLAYBOOK_CMD="ansible-playbook --ask-become-pass --inventory localhost, ${ANSIBLE_PLAYBOOK_PATH}"
SYSTEM_OS="Unknown"
SYSTEM_OS_VERSION="Unknown"
PACKAGE_MANAGER="Unknown"
ROOT_RUN=""


## Func
#

#######################################
# Helper to print error message
# Globals:
#   RED
#   RESET
# Arguments:
#   $@ Error message text
#######################################
error_print() {
	echo ${RED}"Error: $@"${RESET} >&2
}

#######################################
# Print status information about run
# Globals:
#   SYSTEM_OS
#   SYSTEM_OS_VERSION
#   PACKAGE_MANAGER
#   ROOT_RUN
#   TRAVIS
# Arguments:
#   None
#######################################
status_print() {
  printf "\n"
  printf "### INFORMATION\n"
  printf "SYSTEM_OS=$SYSTEM_OS\n"
  printf "SYSTEM_OS_VERSION=$SYSTEM_OS_VERSION\n"
  printf "PACKAGE_MANAGER=$PACKAGE_MANAGER\n"
  printf "ROOT_RUN=$ROOT_RUN\n"
  printf "\n"

  if [ "$TRAVIS" = "true" ]; then
    printf "\n"
    printf "df -h\n"
    df -h
  fi
}

#######################################
# Detects if script is run as root
# Globals:
#   ROOT_RUN
# Arguments:
#   None
#######################################
root_detect() {
  if ! [ $(id -u) -eq 0 ]; then
    ROOT_RUN="sudo "
  fi
}

#######################################
# Detects if command exists, first
# for sudo then for normal user
# Globals:
#   ROOT_RUN
# Arguments:
#   $@ Command to test for
#######################################
command_exists() {
  $ROOT_RUN command -v "$@" >/dev/null 2>&1
}

#######################################
# Detects if command exists else
# run install command
# Globals:
#   ROOT_RUN
# Arguments:
#   $1 Command to test for
#   $2 Command used to install if missing
#######################################
command_install() {
  if ! command_exists $1; then
    printf "\n### INSTALL $1 - run '$ROOT_RUN$2'...\n"
    $ROOT_RUN$2

    if ! command_exists $1; then
      error_print "Command '$1' could not be installed!\n"
      exit 1
    else
      printf "\n... successful\n$1 --version\n"
      $1 --version
    fi
  fi
}

#######################################
# Clone git repository if not existing
# Globals:
#   GIT_CLONE_FOLDER
#   GIT_REPO_URL
# Arguments:
#   None
#######################################
git_clone() {
  if [ ! -d "$GIT_CLONE_FOLDER" ] ; then
      printf "\n### RUN - git clone\n"
      git clone --depth=1 --branch "$GIT_REPO_BRANCH" "$GIT_REPO_URL" "$GIT_CLONE_FOLDER"
  fi
  cd "$GIT_CLONE_FOLDER"
}

#######################################
# Execute ansible with provided recipes
# Globals:
#   TRAVIS
#   ANSIBLE_PLAYBOOK_CMD
# Arguments:
#   None
#######################################
ansible_install_run() {
  if [ "$TRAVIS" = "true" ]; then
    printf "\n### RUN - ${ANSIBLE_PLAYBOOK_CMD} --syntax-check\n"
    ${ANSIBLE_PLAYBOOK_CMD} --syntax-check
  fi

  printf "\n### RUN - ${ANSIBLE_PLAYBOOK_CMD}\n"
  if [ "$TRAVIS" = "true" ]; then
    ${ANSIBLE_PLAYBOOK_CMD} --skip-tags "travis-do-not"
  elif [ "$CORPORATE" = "true" ]; then
    ${ANSIBLE_PLAYBOOK_CMD} --skip-tags "corporate-do-not"
  else
    ${ANSIBLE_PLAYBOOK_CMD}
  fi
}


## Main
#

printf "Install prerequisite for Ansible (python, git, etc.).\n"
printf "Please consider after this is finished there will be a prompt!\n"
root_detect

unameOut="$(uname -s)"
case "${unameOut}" in
    Darwin*)
      SYSTEM_OS="OSX"
      SYSTEM_OS_VERSION=$(defaults read loginwindow SystemVersionStampAsString)
      PACKAGE_MANAGER="brew install"
      status_print

      # https://stackoverflow.com/questions/15371925/how-to-check-if-xcode-command-line-tools-are-installed
      # https://apple.stackexchange.com/questions/107307/how-can-i-install-the-command-line-tools-completely-from-the-command-line
      xcode-select -p >/dev/null 2>&1
      if [ $? -ne 0 ]; then
        printf "Install Apple Command Line Tools for Xcode, "
        printf "which contains 'git' and other tools needed for homebrew.\n"
        printf "Please confirm the following dialog with 'Install'.\n"

        xcode-select --install

        # src https://gist.github.com/phuctm97/946b5ced8cbfabc2f34e489c447456b1
        until $(xcode-select --print-path &> /dev/null); do
          printf "."
          sleep 1
        done

        printf "Apple Command Line Tools for Xcode has finished installing.\n"
      fi

      # TODO Install homebrew currently needs admin rights. So make it work without admin privileges
      # https://www.reddit.com/r/macsysadmin/comments/yf5jsi/homebrew_install_through_an_mdm_script/
      # https://github.com/Honestpuck/homebrew.sh/tree/master
      if ! command_exists brew; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi
      ROOT_RUN="" command_install python3 "$PACKAGE_MANAGER python"
      ROOT_RUN="" command_install ansible "$PACKAGE_MANAGER ansible"

      git_clone
      ansible_install_run
      ;;
    Linux*)
      SYSTEM_OS="Linux"
      SYSTEM_OS_VERSION="\n\n$(cat /etc/os-release)\n"
      if [ -x $(command_exists yum) ]; then
        PACKAGE_MANAGER="yum install -y"
      elif  [ -x $(command_exists apt-get) ]; then
        PACKAGE_MANAGER="apt-get -y install"
      else
        error_print "Unknown package manager. Please add support in script!\n"
      fi
      status_print

      command_install git "$PACKAGE_MANAGER git"
      command_install pip "$PACKAGE_MANAGER python-pip"
      command_install ansible "pip install ansible --upgrade"

      git_clone
      ansible_install_run
      ;;
    *)
      error_print "Unknown operating system: ${unameOut}. Please add support in script!\n"
      ;;
esac
