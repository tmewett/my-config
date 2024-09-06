# -j .5 - search results appear in middle of screen
# -R - don't escape colours and text effects
# -P prompt - the default medium/-m prompt, modified to always show the file
#   (not just on first prompt) and appended with help info like 'man'
set -gx LESS "-j .5 -R -P ?f%f :- .?m(%T %i of %m) .?e(END) ?x- Next\: %x.:?pB%pB\%:byte %bB?s/%s...%t (press h for help or q to quit)\$"

# MacPorts
set -p PATH /opt/local/bin /opt/local/sbin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

if status is-interactive
    abbr --add xc 'x code .'
    abbr --add xcg 'x code .; t lazygit'
    
    if type -q fzf
        function fish_user_key_bindings
            fzf_key_bindings
        end
        source /opt/local/share/fzf/shell/key-bindings.fish
    end
end
