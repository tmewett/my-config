function r -d "browse a directory or open a file"
    set argc (count $argv)
    if test "$argc" -eq 0
        ranger
    else if test -d $argv[1] -a $argc -eq 1
        ranger $argv[1]
    else
        rifle $argv
    end
end
