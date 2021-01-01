#!/usr/bin/env bash -ex

# Uses https://github.com/jakehilborn/displayplacer
# aligns monitors as predefined screens
# run `displayplacer list` to see current setup and copy

# Home setup
HOME_LEFT_EIZO="id:C51EE342-A597-9058-09E8-7C0704AC0A6B res:1920x1080 origin:(-1920,0) degree:0"
HOME_RIGHT_EIZO="id:75197702-14F6-1252-44E2-92DAEF05DE8B res:1920x1080 origin:(0,0) degree:0"
HOME_RIGHT_RETINA="id:4D708ECC-C22E-C615-3830-076C8957A236 res:1440x900 origin:(1920,180) degree:0"

displayplacer "${HOME_RIGHT_EIZO}" "${HOME_RIGHT_RETINA}" "${HOME_LEFT_EIZO}"
