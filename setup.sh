#!/usr/bin/env sh
#
# Script setup Ansible depending on OS

unameOut="$(uname -s)"
case "${unameOut}" in
    Darwin*)
      echo "Detected environment: Mac -> Install pip + ansible"
      sudo command -v pip >/dev/null 2>&1 || { sudo easy_install pip; }
      sudo command -v ansible >/dev/null 2>&1 || { sudo pip install ansible; }
      ansible-playbook -i "localhost," -c local ansible/site.yml
      ;;

    *)
      echo "UNKNOWN OS: ${unameOut}"
      echo "Please enhance script!"
      ;;
esac
