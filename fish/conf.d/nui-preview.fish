function _nui_update_preview -e fish_postexec
    set cwd (pwd)
    if set -q _nui_preview; and test "$_prev_cwd" != $cwd
        ln -fns (pwd) $_nui_preview
        set -g _prev_cwd
    end
end

function nui-preview
    set -g _nui_preview (mktemp -t nui-preview)
    echo $_nui_preview
    open -R $_nui_preview
end

# function nui-stop-preview -e fish_exit
#     rm -f $_nui_preview
# end
