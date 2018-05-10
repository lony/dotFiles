#!/usr/bin/env sh
#
# Script setup Ansible depending on OS

## Config
ANSIBLE_PLAYBOOK_PATH="ansible/site.yml"
ANSIBLE_CMD="ansible-playbook -i \"localhost,\" -c local ${ANSIBLE_PLAYBOOK_PATH}"

# If test are run on travis avoid space intensive tasks
if [ "$TRAVIS" == "true" ]; then

  CMD_ANSIBLE=$(cat <<EOF
echo "\n### RUN df" &&
df -h &&
echo "\n### RUN ansible - install" &&
${ANSIBLE_CMD} --skip-tags "travis-do-not"
EOF
)

else

  CMD_ANSIBLE=$(cat <<EOF
echo "\n### RUN ansible - install" &&
${ANSIBLE_CMD}
EOF
)

fi

unameOut="$(uname -s)"
case "${unameOut}" in
    Darwin*)
      echo "\n### ENV\nOSX"
      echo "\n### INSTALL pip"
      sudo command -v pip >/dev/null 2>&1 || { echo "... have to" && sudo easy_install pip; }
      echo "\n### INSTALL ansible"
      sudo command -v ansible >/dev/null 2>&1 || { echo "... have to" && sudo pip install ansible; }
      echo "\n### RUN ansible - check syntax"
      ${ANSIBLE_CMD} --syntax-check
      eval $CMD_ANSIBLE
      ;;

    *)
      echo "UNKNOWN OS: ${unameOut}"
      echo "Please enhance script!"
      ;;
esac
