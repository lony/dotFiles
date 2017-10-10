#!/usr/bin/env sh
#
# Script setup Ansible depending on OS

# If test are run on travis avoid space intensive tasks
if [ "$TRAVIS" == "true" ]; then
  CMD_ANSIBLE='echo "\n### SPACE" && df -h && echo "\n### SETUP" && ansible-playbook -i "localhost," -c local ansible/site.yml --skip-tags "travis-do-not"'
else
  CMD_ANSIBLE='echo "\n### SETUP" && ansible-playbook -i "localhost," -c local ansible/site.yml'
fi

unameOut="$(uname -s)"
case "${unameOut}" in
    Darwin*)
      echo "\n### ENV\nOSX -> Install pip + ansible"
      sudo command -v pip >/dev/null 2>&1 || { sudo easy_install pip; }
      sudo command -v ansible >/dev/null 2>&1 || { sudo pip install ansible; }
      eval $CMD_ANSIBLE
      ;;

    *)
      echo "UNKNOWN OS: ${unameOut}"
      echo "Please enhance script!"
      ;;
esac
