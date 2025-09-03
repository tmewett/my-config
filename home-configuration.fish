set my_config_dir (dirname (status filename))

function _dl_ta
    test -e $HOME/.textadept-bin
    or not hc_doing "downloading textadept"
    and return
    set dir (mktemp -d)
    cd $dir
    curl -LO https://github.com/orbitalquark/textadept/releases/download/textadept_12.7/textadept_12.7.linux.tgz
    and tar -xaf textadept_12.7.linux.tgz
    and mv -T textadept $HOME/.textadept-bin
    cd -
    rm -r $dir
end

set -q textadept; hc_if
    hc_then _dl_ta
    hc_then_symlink $HOME/.textadept-bin/textadept $HOME/.local/bin/textadept
    # hc_then_symlink $my_config_dir/textadept/init.lua $HOME/.config/

set -q kakoune_dir; hc_if
    hc_then_symlink $kakoune_dir/src/kak $HOME/.local/bin/kak
    hc_then_symlink $kakoune_dir/rc $HOME/.config/kak/autoload/rc
    hc_then_symlink $my_config_dir/kakoune $HOME/.config/kak/autoload/my_config

test -d /etc/apparmor.d; hc_if

false; hc_if
    hc_then_sudo_put_file $my_config_dir/bwrap.apparmor /etc/apparmor.d/bwrap

hc_safe_rm_symlink ~/.config/fish/conf.d
