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

uname -a

unameOut="$(uname -s)"
case "${unameOut}" in
    Darwin*)
      echo "\n### ENV\nOSX"
      echo "\n### INSTALL pip + ansible"
      sudo command -v pip >/dev/null 2>&1 || { sudo easy_install pip; }
      sudo command -v ansible >/dev/null 2>&1 || { sudo pip install ansible; }
      eval $CMD_ANSIBLE
      ;;

    *)
      echo "UNKNOWN OS: ${unameOut}"
      echo "Please enhance script!"
      ;;
esac
