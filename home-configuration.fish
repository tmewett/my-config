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
    hc_then_symlink $my_config_dir/textadept/init.lua $HOME/.config/
hc_end

false; hc_if
    hc_then_symlink $kakoune_dir/src/kak $HOME/.local/bin/kak
    hc_then_symlink $kakoune_dir/rc $HOME/.config/kak/autoload/rc
    hc_then_symlink $my_config_dir/kakoune $HOME/.config/kak/autoload/my_config
hc_end

test -d /etc/apparmor.d; hc_if
    hc_then_sudo_put_file $my_config_dir/bwrap.apparmor /etc/apparmor.d/bwrap
hc_end

true; hc_if
    hc_then_symlink $my_config_dir/settings.json ~/.config/Code/User/settings.json
    hc_then_symlink $my_config_dir/keybindings.json ~/.config/Code/User/keybindings.json
    hc_then_symlink $my_config_dir/snippets ~/.config/Code/User/snippets
hc_end

hc_safe_symlink $my_config_dir/fish/functions ~/.config/fish/functions
hc_safe_rm_symlink ~/.config/fish/conf.d
