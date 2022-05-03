function man --wraps=man
    if set -q NUI_MAN_OPENER && set -q _NUI_GRAPHICAL
        # We have to use a new temp file for openers which would reload on change.
        set file (mktemp)
        command man $argv > $file
        $NUI_MAN_OPENER $file
        # We can't delete since the opener may take some time to read the file.
    else
        command man $argv
    end
end
