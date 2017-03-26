#!/usr/bin/env python
#
# Script parses multiple shell configuration and
# generates resulting configuration files from dot-repo.

import os, sys

#
# Config

current_path = os.path.dirname(__file__)
list = {
    "use": [{
        "shell": "vim",
        "framework": "default",
    }, {
        "shell": "bash",
        "framework": "default",
    }, {
        "shell": "zsh",
        "framework": "oh-my-zsh",
    }],
	"vim": {
        "outfile": os.path.abspath(os.path.expanduser('~') + '/.vimrc'),
        "comment_char": '"',
		"default": [
            os.path.join(current_path, '..', "vim"),
        ],
	},
    "bash": {
        "outfile": os.path.abspath(os.path.expanduser('~') + '/.bash_profile'),
        "comment_char": "#",
		"default": [
            os.path.join(current_path, '..', 'sh', "all.sh"),
            os.path.join(current_path, '..', 'sh', "all_secret.sh"),
            os.path.join(current_path, '..', 'sh', "bash.bash"),
        ],
    },
    "zsh": {
        "outfile": os.path.abspath(os.path.expanduser('~') + '/.zshrc'),
        "comment_char": "#",
        "default": [
            os.path.join(current_path, '..', 'sh', "all.sh"),
            os.path.join(current_path, '..', 'sh', "all_secret.sh"),
            os.path.join(current_path, '..', 'sh', "zsh.zsh"),
        ],
        "oh-my-zsh": [
            os.path.join(current_path, '..', 'sh', "all.sh"),
            os.path.join(current_path, '..', 'sh', "all_secret.sh"),
            os.path.join(current_path, '..', 'sh', "zsh_oh-my.zsh"),
            os.path.join(current_path, '..', 'sh', "zsh.zsh"),
        ],
        "prezto": [
            os.path.join(current_path, '..', 'sh', "all.sh"),
            os.path.join(current_path, '..', 'sh', "all_secret.sh"),
           	os.path.join(current_path, '..', 'sh', "zsh_prezto.zsh"),
            os.path.join(current_path, '..', 'sh', "zsh.zsh"),
        ],
        "zim": [
            os.path.join(current_path, '..', 'sh', "all.sh"),
            os.path.join(current_path, '..', 'sh', "all_secret.sh"),
            os.path.join(current_path, '..', 'sh', "zsh_zim.zsh"),
            os.path.join(current_path, '..', 'sh', "zsh.zsh"),
        ],
    },
}


def create_single_config(shell, framework):

    outfile = list[shell]["outfile"]
    comment_char = list[shell]["comment_char"]

    # Give status
    msg = """
shell=		{}
framework=	{}
outfile=	{}	IMPORTANT: Will be overwritten!
	""".format(
        shell,
        framework,
        outfile, )
    print msg

    # Confirm
    shall = raw_input("Overwrite (y/N) ").lower() == 'y'

    if not shall:
        exit()

    print

    # Parse
    with open(outfile, 'w') as file_out_handler:

        for file_in in list[shell][framework]:

            # Build absolute path
            file_in = os.path.abspath(file_in)
            print("> {}".format(file_in))

            with open(file_in, 'r') as file_in_handler:

                for line in file_in_handler:

                    # Skip comment and empty lines
                    if not line.strip().startswith(comment_char) and line.strip():
                        file_out_handler.write(line)

            file_in_handler.close()


if __name__ == '__main__':

    print "concat_files - Update shell configuration"

    for config in list["use"]:
        create_single_config(
            config["shell"],
            config["framework"],
		)
