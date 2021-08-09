function __nui_vars
    if not set -q NUI_EDITOR
        set -g NUI_EDITOR xdg-open
    end

    if not set -q NUI_TERMINAL_EDITOR
        which nano > /dev/null 2>&1
        and set -g NUI_TERMINAL_EDITOR nano
        or which vim > /dev/null 2>&1
        and set -g NUI_TERMINAL_EDITOR vim
    end
end
