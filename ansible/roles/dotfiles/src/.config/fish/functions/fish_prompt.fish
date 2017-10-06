function fish_prompt --description 'Write out the prompt'
	#Save the return status of the previous command
    set stat $status

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end
    if not set -q __fish_color_blue
        set -g __fish_color_blue (set_color blue)
    end
    if not set -q __fish_color_cyan
        set -g __fish_color_cyan (set_color cyan)
    end
    if not set -q __fish_color_magenta
        set -g __fish_color_magenta (set_color magenta)
    end
    if not set -q __fish_color_yellow
        set -g __fish_color_yellow (set_color yellow)
    end
    if not set -q __fish_color_red
        set -g __fish_color_red (set_color red)
    end

    #Set the color for the status depending on the value
    set __fish_color_status (set_color -o green)
    if test $stat -gt 0
        set __fish_color_status (set_color -o red)
    end

    # GIT
    if not set -q -g __fish_robbyrussell_functions_defined
        set -g __fish_robbyrussell_functions_defined
        function _git_branch_name
            echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
        end

        function _is_git_dirty
            echo (git status -s --ignore-submodules=dirty ^/dev/null)
        end

        function _is_git_repo
            type -q git
            or return 1
            git status -s >/dev/null ^/dev/null
        end

        function _repo_branch_name
            eval "_$argv[1]_branch_name"
        end

        function _is_repo_dirty
            eval "_is_$argv[1]_dirty"
        end

        function _repo_type
            if _is_git_repo
                echo 'git'
            end
        end
    end

    set -l repo_type (_repo_type)
    if [ $repo_type ]
        set -l repo_branch $__fish_color_red(_repo_branch_name $repo_type)
        set repo_info "$__fish_prompt_normal| $repo_branch$__fish_color_blue"

        if [ (_is_repo_dirty $repo_type) ]
            set -l dirty "$__fish_color_yellow✗"
            set repo_info "$repo_info$dirty"
        end
    end
    # END Git

    switch $USER

        case root toor

            if not set -q __fish_prompt_cwd
                if set -q fish_color_cwd_root
                    set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
                else
                    set -g __fish_prompt_cwd (set_color $fish_color_cwd)
                end
            end

            printf '%s@%s %s%s%s# ' $USER (prompt_hostname) "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal"

        case '*'

            if not set -q __fish_prompt_cwd
                set -g __fish_prompt_cwd (set_color $fish_color_cwd)
            end

            printf '\f\r[ %s%s%s | %s | %s%s%s@%s%s %s %s] %s%s %s\f\r❯ ' "$__fish_color_status" "$stat" "$__fish_prompt_normal" (date "+%g-%m-%d %H:%M:%S") "$__fish_color_magenta" $USER "$__fish_prompt_normal" "$__fish_color_cyan" (prompt_hostname) "$repo_info" "$__fish_prompt_normal" "$__fish_prompt_cwd" "$PWD" "$__fish_prompt_normal"

    end
end
