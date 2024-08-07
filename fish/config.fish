if status is-interactive
    # Commands to run in interactive sessions can go here
end

abbr --add xc 'x code .'
abbr --add xcg 'x code .; t lazygit'

# MacPorts
set -p PATH /opt/local/bin /opt/local/sbin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

function fish_user_key_bindings
    fzf_key_bindings
end
source /opt/local/share/fzf/shell/key-bindings.fish
