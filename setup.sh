#!/usr/bin/env sh
#
# Script setup Ansible depending on OS

## Config
PIP_CMD="pip"
ANSIBLE_CMD="ansible"
ANSIBLE_PLAYBOOK_PATH="ansible/site.yml"
ANSIBLE_PLAYBOOK_CMD="ansible-playbook -i \"localhost,\" -c local ${ANSIBLE_PLAYBOOK_PATH}"

# If test are run on travis avoid space intensive tasks
if [ "$TRAVIS" == "true" ]; then

  CMD_ANSIBLE=$(cat <<EOF
printf "\n### RUN df\n" &&
df -h &&
printf "\n### RUN ansible-playbook - install\n" &&
${ANSIBLE_PLAYBOOK_CMD} --skip-tags "travis-do-not"
EOF
)

else

  CMD_ANSIBLE=$(cat <<EOF
printf "\n### RUN ansible-playbook - install\n" &&
${ANSIBLE_PLAYBOOK_CMD}
EOF
)

fi

unameOut="$(uname -s)"
case "${unameOut}" in
    Darwin*)
      printf "\n### ENV\nOSX\n"
      printf "\n### INSTALL ${PIP_CMD}\n"
      sudo command -v $PIP_CMD >/dev/null 2>&1 || { printf "... have to\n" && sudo easy_install $PIP_CMD; }
      $PIP_CMD --version
      printf "\n### INSTALL ${ANSIBLE_CMD}\n"
      sudo command -v $ANSIBLE_CMD >/dev/null 2>&1 || { printf "... have to\n" && sudo $PIP_CMD install $ANSIBLE_CMD --upgrade; }
      $ANSIBLE_CMD --version
      printf "\n### RUN ansible-playbook - check syntax\n"
      ${ANSIBLE_PLAYBOOK_CMD} --syntax-check
      eval $CMD_ANSIBLE
      ;;

    *)
      printf "UNKNOWN OS: ${unameOut}\n"
      printf "Please enhance script!\n"
      ;;
esac
