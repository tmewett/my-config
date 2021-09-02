function rm --wraps=rm
    __nui_vars
    if status is-interactive
    and test "$NUI_RM_TRASHES" = "true"
    and type -q trash
        trash $argv
    else
        command rm $argv
    end
end
