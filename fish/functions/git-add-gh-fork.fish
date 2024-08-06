function git-add-gh-fork -a forkname
    set origin (git remote get-url origin)
    set repo (string match -r '/(.+)\.git$' $origin)
    git remote add "fork/$forkname" "git@github.com:$forkname/$repo[2].git"
end
