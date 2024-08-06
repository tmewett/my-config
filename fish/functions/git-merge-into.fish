function git-merge-into
    set dest $argv[1]
    set argc (count $argv)
    if test $argc -eq 2
        set src $argv[2]
    else
        set src (git rev-parse --abbrev-ref HEAD)
    end
    git checkout $dest
    and git merge $src
end
