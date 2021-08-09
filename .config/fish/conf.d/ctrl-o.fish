bind \co 'begin
    set -l sel (fzf --no-sort)
    and r $sel
end'
