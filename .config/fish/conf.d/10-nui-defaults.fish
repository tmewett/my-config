if not set -q NUI_EDITOR
    set -g NUI_EDITOR xdg-open
end

if not set -q NUI_TERMINAL_EDITOR
    if type -q nano
        set -g NUI_TERMINAL_EDITOR nano
    else if type -q vim
        set -g NUI_TERMINAL_EDITOR vim
    end
end

if not set -q NUI_RM_TRASHES
    set -g NUI_RM_TRASHES true
end

if not set -q NUI_H_NEW_TERMINAL
    set -g NUI_H_NEW_TERMINAL true
end

if not set -q NUI_TERMINAL_CMD
    if type -q exo-open
        set -g NUI_TERMINAL_CMD exo-open --launch TerminalEmulator
    else if type -q gnome-terminal
        set -g NUI_TERMINAL_CMD gnome-terminal --
    end
end

if test (uname -s) = Darwin
    set _NUI_MACOS
end

if set -q _NUI_MACOS; or set -q DISPLAY
    set _NUI_GRAPHICAL
end
