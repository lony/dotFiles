#!/usr/bin/env sh
#
# Script setup Ansible depending on OS

# If test are run on travis avoid space intensive tasks
if [ "$TRAVIS" == "true" ]; then
  CMD_ANSIBLE='\
  echo "\n### RUN df" && \
  df -h && \
  echo "\n### RUN ansible" && \
  ansible-playbook -i "localhost," -c local ansible/site.yml --skip-tags "travis-do-not"'
else
  CMD_ANSIBLE='\
  echo "\n### RUN ansible" && \
  ansible-playbook -i "localhost," -c local ansible/site.yml'
fi

unameOut="$(uname -s)"
case "${unameOut}" in
    Darwin*)
      echo "\n### ENV\nOSX"
      echo "\n### INSTALL pip"
      sudo command -v pip >/dev/null 2>&1 || { echo "... have to" && sudo easy_install pip; }
      echo "\n### INSTALL ansible"
      sudo command -v ansible >/dev/null 2>&1 || { echo "... have to" && sudo pip install ansible; }
      eval $CMD_ANSIBLE
      ;;

    *)
      echo "UNKNOWN OS: ${unameOut}"
      echo "Please enhance script!"
      ;;
esac
