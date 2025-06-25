# My portable config. System-specific goes in ../config.fish

set MSYS2_ENV_CONV_EXCL "$MSYS2_ENV_CONV_EXCL;GEM_PATH"

# reset to default in case it was set in a parent
set -e MSYS2_ARG_CONV_EXCL

abbr -a -- xc x code
abbr -a -- lg wt lazygit
abbr -a -- e. explorer .

# -j .5 - search results appear in middle of screen
# -R - don't escape colours and text effects
# -P prompt - the default medium/-m prompt, modified to always show the file
#   (not just on first prompt) and appended with help info like 'man'
set -gx LESS "-j .5 -R -P ?f%f :- .?m(%T %i of %m) .?e(END) ?x- Next\: %x.:?pB%pB\%:byte %bB?s/%s...%t (press h for help or q to quit)\$"

if status is-interactive
    function fish_user_key_bindings
        if type -q fzf
            fzf_key_bindings
        end
        fish_vi_key_bindings
    end
end

set -e fish_user_paths
set -p PATH ~/.local/bin (dirname (status filename))/../../bin
