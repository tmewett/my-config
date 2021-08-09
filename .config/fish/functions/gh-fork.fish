function gh-fork --argument user
    set origin (git remote get-url origin)
    and set repo (string match -r '/(.+)\.git$' $origin)
    and echo "git@github.com:$user/$repo[2].git"
    or return 1
end
