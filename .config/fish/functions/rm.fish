function rm --wraps=rm
    if status is-interactive
    and begin
        test "$NUI_RM_TRASHES" = "true"
        or not set -q NUI_RM_TRASHES
        and which trash >/dev/null 2>&1
    end
        trash $argv
    else
        command rm $argv
    end
end
