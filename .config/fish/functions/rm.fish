function rm --wraps=rm
    if status is-interactive
    and test "$NUI_RM_TRASHES" = "true"
    and type -q trash
        trash $argv
    else
        command rm $argv
    end
end
