function _multifish_do_others -a cmd -e fish_postexec
    if not string match -eq -- 'multifish*' $cmd; and set -q _multifish_others
        for dir in $_multifish_others
            cd $dir
            eval $cmd &| string replace -r ^ "[$dir] "
        end
        cd $_multifish_first
    end
end

function multifish
    if set -q _multifish_others
        cd $_multifish_init
        set -e _multifish_first
        set -e _multifish_others
        set -e _multifish_init
    else
        set -g _multifish_first (realpath $argv[1])
        and set -g _multifish_others (realpath $argv[2..])
        and set -g _multifish_init (pwd)
        and cd $argv[1]
        and echo "entering multifish - run 'multifish' again to leave"
    end
end

# function multifish
#     if test "$argv[1]" = "--start"
#         set -g _multifish_first (realpath $argv[2])
#         and set -g _multifish_others (realpath $argv[3..])
#         and echo "entering multifish - type 'exit' or ctrl-d to leave"
#         and cd $argv[2]
#         or exit 1
#     else
#         fish -C (string join -- ' ' "multifish --start" (string escape -- $argv))
#     end
# end
