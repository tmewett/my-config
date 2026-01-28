# My portable config. System-specific goes in the real config.fish

set -x MSYS2_ENV_CONV_EXCL "$MSYS2_ENV_CONV_EXCL;GEM_PATH"

# reset to default in case it was set in a parent
set -e MSYS2_ARG_CONV_EXCL

# -F - quit if one screen
# -j .5 - search results appear in middle of screen
# -R - don't escape colours and text effects
# -P prompt - the default medium/-m prompt, modified to always show the file
#   (not just on first prompt) and appended with help info like 'man'
set -x LESS "-F -j .5 -R -P ?f%f :- .?m(%T %i of %m) .?e(END) ?x- Next\: %x.:?pB%pB\%:byte %bB?s/%s...%t (press h for help or q to quit)\$"

# this doesn't take into account ignorefiles
set -x FZF_DEFAULT_COMMAND "find . \( -name .git -or -name \*venv \) -prune -or ! -type d -printf '%P\n'"

if status is-interactive
    abbr -a -- g t w lazygit
    fish_hybrid_key_bindings
    function fish_user_key_bindings
        if type -q fzf
            if test -e /ucrt64/bin/fzf
                source /ucrt64/share/fish/vendor_functions.d/fzf_key_bindings.fish
            end
            fzf_key_bindings
        end
        function _fzf_open
            set file (fzf --height=40%)
            and o $file
            commandline -f repaint
        end
        bind \co _fzf_open
        bind -M insert \co _fzf_open
    end
    function d -a name
        if test -z "$name"
            ls ~/.config/d
            return
        end
        set dir "$(cat ~/.config/d/$name)"
        and cd $dir
    end
    function dsave -a name
        mkdir -p ~/.config/d
        and echo -n $PWD > ~/.config/d/$name
    end
    function p
        cd -
    end
    function nuke
        # -R also makes chmod ignores symlinks, so we can't use find -exec chmod
        chmod -R 777 $argv[1]
        and rm -r $argv[1]
    end
    function gh-fork-branch -a specString
        set spec (string split -- : $specString)
        and set remote_url (string replace -r -- ':\w+/' :$spec[1]/)
        and git remote add fork/$spec[1] $remote_url
        and git switch $spec[2]
    end
    function _reversed_prompt_cwd
        set cwd (string split / -- (prompt_pwd))
        echo -n $cwd[-1]
        for part in $cwd[-2..1]
            echo -n "\\$part"
        end
    end
    function fish_title
        echo -n $_ ' '
        _reversed_prompt_cwd
    end
    function t
        if set -q argv[1]
            set set_title_cmd (string escape -- echo -n \e"]0;$argv[1]  $(_reversed_prompt_cwd)"\e\\)
            set argv_cmd (string escape -- $argv)
            set cmd fish -c "$set_title_cmd; $argv"
            if set -q MSYSTEM
                echo "$set_title_cmd; $argv" > /tmp/t_cmd
                set msys_cmd C:\\msys64\\msys2_shell.cmd -defterm -no-start -here -c "exec fish /tmp/t_cmd"
            end
        end
        if w -q wt
            w wt nt -p MSYS2 $msys_cmd
        end
        if type -q gnome-terminal
            x gnome-terminal -- $cmd
        end
    end
    if test $(hostname) = "phoenix"
        function prepare-backup
            pushd $tom/files/projects
            or return 1
            for d in *
                cd $d
                w git gc
                cd ..
            end
            popd
        end
        function backup
            pushd $tom/files
            or return 1
            ~/borg.venv/bin/python -m borg create -C auto,zstd --progress --patterns-from borg-filter ::windows-from-msys2-\{now\} . ../AppData/vault
        end
    end
end

set my_config_dir (dirname (status filename))/..
set -e fish_user_paths
set -p PATH ~/.local/bin $my_config_dir/bin
if set -q MSYSTEM
    set -p PATH $my_config_dir/bin.msys2
end

set -x E_EDITOR "x code"

if test -e /c/Users/Tom
    set -x tom /c/Users/Tom
end

# rustup
if test -e $HOME/.cargo/env.fish
    source $HOME/.cargo/env.fish
end
