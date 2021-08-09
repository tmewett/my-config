function git-cleanup-branches
    git branch -rD (git branch -r | string trim | grep 'fork/')
    git branch -D (git branch | string trim | grep 'pr/')
end
