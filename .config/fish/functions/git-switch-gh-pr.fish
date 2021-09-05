function git-switch-gh-pr
    git-fetch-gh-pr $argv
    and git checkout pr/$argv[-1]
end
