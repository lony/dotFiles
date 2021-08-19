#!/usr/bin/env sh
#
# Script to prepare everything depending on operating system
# so that Ansible can run independently

set -ex


## Config
#

GIT_CMD="git"
GIT_REPO_URL="https://github.com/lony/dotFiles.git"
GIT_CLONE_FOLDER="$HOME/dotFiles"
PIP_CMD="pip"
PIP_PACKAGE="python-pip"
ANSIBLE_CMD="ansible"
ANSIBLE_PLAYBOOK_PATH="ansible/site.yml"
ANSIBLE_PLAYBOOK_CMD="ansible-playbook --inventory localhost, ${ANSIBLE_PLAYBOOK_PATH}"
SYSTEM_OS="Unknown"
SYSTEM_OS_VERSION="Unknown"
PACKAGE_MANAGER="Unknown"
ROOT_RUN=""


## Func
#

# Print error message
error_print() {
	echo ${RED}"Error: $@"${RESET} >&2
}

# Detects if script is run as root
root_detect() {
  if ! [ $(id -u) -eq 0 ]; then
    ROOT_RUN="sudo "
  fi
}

# Detects if command exists, first for sudo then for normal user
command_exists() {
  $ROOT_RUN command -v "$@" >/dev/null 2>&1
}

# Detects if command exists else runs install command
command_install() {
      if ! command_exists $1; then
        printf "\n### INSTALL $1\n"
        printf "  ... have to\n"
        $ROOT_RUN$2
      fi
}

# Clone git repository if not existing
git_clone() {
  if [ ! -d "$GIT_CLONE_FOLDER" ] ; then
      printf "\n### RUN ${GIT_CMD} clone\n"
      git clone --depth=1 --branch master "$GIT_REPO_URL" "$GIT_CLONE_FOLDER"
  fi
}

# Run ansible after showing debug information
ansible_install_run() {
  git_clone
  cd "$GIT_CLONE_FOLDER"

  printf "\n"
  printf "### INFORMATION\n"
  printf "SYSTEM_OS=$SYSTEM_OS\n"
  printf "SYSTEM_OS_VERSION=$SYSTEM_OS_VERSION\n"
  printf "PACKAGE_MANAGER=$PACKAGE_MANAGER\n"
  printf "ROOT_RUN=$ROOT_RUN\n"
  printf "\n"
  python --version
  $PIP_CMD --version
  $ANSIBLE_CMD --version

  if [ "$TRAVIS" == "true" ]; then
    printf "\n"
    printf "SPACE\n"
    df -h

    printf "\n### RUN ansible-playbook - check syntax\n"
    ${ANSIBLE_PLAYBOOK_CMD} --syntax-check
  fi

  printf "\n### RUN ansible-playbook - install\n"
  if [ "$TRAVIS" == "true" ]; then
    ${ANSIBLE_PLAYBOOK_CMD} --skip-tags "travis-do-not"
  else
    ${ANSIBLE_PLAYBOOK_CMD}
  fi
}


## Main
#

printf "Start installing Ansible prerequisites (git, etc.).\n"
printf "After this is finished there is a prompt coming - be prepared!\n"
root_detect

unameOut="$(uname -s)"
case "${unameOut}" in
    Darwin*)
      SYSTEM_OS="OSX"
      SYSTEM_OS_VERSION=$(defaults read loginwindow SystemVersionStampAsString)
      PACKAGE_MANAGER="brew install"

      # https://apple.stackexchange.com/questions/107307/how-can-i-install-the-command-line-tools-completely-from-the-command-line
      #xcode-select --install
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

      ROOT_RUN="" command_install python "$PACKAGE_MANAGER python"
      ROOT_RUN="" command_install $ANSIBLE_CMD "$PACKAGE_MANAGER $ANSIBLE_CMD"

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
        error_print "UNKNOWN Package manager\nPlease add support in script!\n"
      fi

      command_install $GIT_CMD "$PACKAGE_MANAGER $GIT_CMD"
      command_install $PIP_CMD "$PACKAGE_MANAGER $PIP_PACKAGE"
      command_install $ANSIBLE_CMD "$PIP_CMD install $ANSIBLE_CMD --upgrade"

      ansible_install_run
      ;;
    *)
      error_print "UNKNOWN OS: ${unameOut}\nPlease add support in script!\n"
      ;;
esac
