# My portable config. System-specific goes in the real config.fish

set MSYS2_ENV_CONV_EXCL "$MSYS2_ENV_CONV_EXCL;GEM_PATH"

# reset to default in case it was set in a parent
set -e MSYS2_ARG_CONV_EXCL

# -j .5 - search results appear in middle of screen
# -R - don't escape colours and text effects
# -P prompt - the default medium/-m prompt, modified to always show the file
#   (not just on first prompt) and appended with help info like 'man'
set -gx LESS "-j .5 -R -P ?f%f :- .?m(%T %i of %m) .?e(END) ?x- Next\: %x.:?pB%pB\%:byte %bB?s/%s...%t (press h for help or q to quit)\$"

abbr -a -- c x code
abbr -a -- g t w lazygit
abbr -a -- r explorer .

if status is-interactive
    function fish_user_key_bindings
        if type -q fzf
            fzf_key_bindings
        end
        fish_vi_key_bindings
    end
end

set -e fish_user_paths
set -p PATH ~/.local/bin (dirname (status filename))/../bin

# rustup
if test -e $HOME/.cargo/env.fish
    source $HOME/.cargo/env.fish
end

if type -q gnome-terminal
    set -x T_TERMINAL gnome-terminal --
else if w -q wt
    set -x T_TERMINAL 'w wt nt -p MSYS2'
end

if w -q zoxide
    w zoxide init fish | source
end
