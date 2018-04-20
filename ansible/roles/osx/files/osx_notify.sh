#!/usr/bin/env bash -ex

# cron entry, via crontab -e, test via crontab -l
# 2 21  * * * ~/dotFiles/ansible/roles/osx/files/osx_notify.sh

TITLE="Sleep Timer"
MESSAGE="Use headspace and then go to bed! It is already 21 o clock!"
SOUND="Glass"

# https://apple.stackexchange.com/questions/57412/how-can-i-trigger-a-notification-center-notification-from-an-applescript-or-shel
# https://stackoverflow.com/questions/23923017/osascript-using-bash-variable-with-a-space
osascript -e "display notification \"${MESSAGE}\" sound name \"${SOUND}\" with title \"${TITLE}\""
