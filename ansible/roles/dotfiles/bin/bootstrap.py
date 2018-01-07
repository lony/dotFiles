#!/usr/bin/env python
#
# Script concat and copies shell configuration and
# generates resulting configuration files

import os
import sys
import logging
from distutils.dir_util import copy_tree
from pprint import pprint as pp

#
# Config

logging.basicConfig(
    format="%(message)s",  # https://docs.python.org/2/library/logging.html#logrecord-attributes
    level=logging.INFO,
    stream=sys.stdout,
)

path_self = os.path.dirname(__file__)
path_files = os.path.join(path_self, '..', 'src')
path_target = os.path.expanduser('~')

config = [
    {"sys": "bash"},
    {"sys": "zsh", "framework": "oh-my-zsh"},
    {"sys": "fish"},
    {"sys": "ssh"},
]

system_list = {
    "bash": {
        "default": {
            "handler": "concat",
            "fileList": [
                os.path.join(path_files, "bash_zsh", "all.sh"),
                os.path.join(path_files, "bash_zsh", "all_secret.sh"),
                os.path.join(path_files, "bash_zsh", "bash.bash"),
            ],
            "comment_char": '#',
            "outfile": path_target + '/.bash_profile',
        },
    },
    "zsh": {
        "default": {
            "handler": "concat",
            "fileList": [
                os.path.join(path_files, "bash_zsh", "all.sh"),
                os.path.join(path_files, "bash_zsh", "all_secret.sh"),
                os.path.join(path_files, "bash_zsh", "zsh.zsh"),
            ],
            "comment_char": '#',
            "outfile": path_target + '/.zshrc',
        },
        "oh-my-zsh": {
            "handler": "concat",
            "fileList": [
                os.path.join(path_files, "bash_zsh", "all.sh"),
                os.path.join(path_files, "bash_zsh", "all_secret.sh"),
                os.path.join(path_files, "bash_zsh", "zsh_oh-my.zsh"),
                os.path.join(path_files, "bash_zsh", "zsh.zsh"),
            ],
            "comment_char": '#',
            "outfile": path_target + '/.zshrc',
            "dependsPost": [
                {"sys": "zsh_oh-my-zsh_theme"}
            ]
        },
    },
    "zsh_oh-my-zsh_theme": {
        "default": {
            "handler": "copy",
            "source": os.path.join(path_files, "bash_zsh", ".zsh_oh-my-zsh"),
            "destination": path_target,
        },
    },
    "fish-config": {
        "default": {
            "handler": "copy",
            "source": os.path.join(path_files, ".config"),
            "destination": path_target,
        },
    },
    "fish": {
        "default": {
            "dependsPre": [
                {"sys": "fish-config"}
            ],
            "handler": "concat",
            "fileList": [
                os.path.join(path_files, "fish.fish"),
            ],
            "comment_char": '#',
            "outfile": path_target + '/.config/fish/config.fish',
        },
    },
    "ssh": {
        "default": {
            "handler": "copy",
            "source": os.path.join(path_files, ".ssh"),
            "destination": path_target,
        },
    },
}


def concat(sysData):

    logging.debug("Concat into file: {}".format(
        os.path.relpath(sysData["outfile"])))

    with open(os.path.abspath(sysData["outfile"]), 'w') as file_out_handler:

        for file_in in sysData["fileList"]:

            logging.debug("\t Process file: {}".format(
                os.path.relpath(file_in)))

            with open(os.path.abspath(file_in), 'r') as file_in_handler:

                for line in file_in_handler:

                    if not line.strip().startswith(sysData["comment_char"]) and line.strip():
                        file_out_handler.write(line)

            file_in_handler.close()

        file_out_handler.close()


def copy(sysData):

    logging.info("Copy folder: {} to: {}".format(
        os.path.relpath(sysData["source"]),
        os.path.abspath(sysData["destination"])
    ))

    source_abs = os.path.abspath(sysData["source"])
    destination_abs = os.path.abspath(
        os.path.join(sysData["destination"], os.path.basename(source_abs))
    )

    copy_tree(
        source_abs,
        destination_abs
    )


def action_exec(sysElem):
    # Get framework to use in sys
    framework = (sysElem['framework'] if 'framework' in sysElem else 'default')
    logging.info("Setup '{}'\t-> '{}'".format(
        sysElem['sys'],
        framework,
    ))
    sysFromConfig = system_list[sysElem['sys']][framework]

    # Get dependsPre action
    if 'dependsPre' in sysFromConfig:
        for preAction in sysFromConfig['dependsPre']:
            action_exec(preAction)

    # Get framework handler and execute
    handler = getattr(sys.modules[__name__], sysFromConfig['handler'])
    handler(sysFromConfig)

    # Get dependsPost action
    if 'dependsPost' in sysFromConfig:
        for postAction in sysFromConfig['dependsPost']:
            action_exec(postAction)


if __name__ == '__main__':

    for sysElem in config:
        action_exec(sysElem)
