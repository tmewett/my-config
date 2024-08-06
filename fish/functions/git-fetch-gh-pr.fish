function git-fetch-gh-pr
    git fetch $argv[1..-2] origin refs/pull/$argv[-1]/head:pr/$argv[-1]
end
