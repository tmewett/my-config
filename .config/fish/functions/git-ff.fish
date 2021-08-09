function git-ff --wraps='git checkout'
    git checkout $argv
    and git merge --ff-only
end
