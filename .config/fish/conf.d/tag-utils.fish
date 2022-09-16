function lt
    if test (count $argv) -eq 0
        tmsu tags
        return
    end
    ls -d (tmsu files -- $argv)
end

function llt
    if test (count $argv) -eq 0
        tmsu tags
        return
    end
    ls -ld (tmsu files -- $argv)
end

function cht
    set -l to_add
    set -l to_rem
    set -l files
    for s in $argv
        if string match -- '=*' $s
            set -a to_add $s
        else if string match -- '-*' $s
            set -a to_rem $s
        # else if "$s" = "--"
        else
            set -a files $s
        end
    end
    if test (count $to_add) -gt 0
        tmsu tag --tags="$(string sub --start 2 -- $to_add)" $files
        or return
    end
    if test (count $to_rem) -gt 0
        tmsu untag --tags="$(string sub --start 2 -- $to_rem)" $files
        or return
    end
end
