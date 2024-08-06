function git-tag-version
    set ver $argv[1]
    git tag -a v$ver -m "Version $ver"
end
