set my_config_dir (dirname (status filename))
if not set -q APPDATA; set APPDATA ~/.config; end
if not set -q USERPROFILE; set USERPROFILE ~; end

if set -q MSYSTEM
    set vscode_config_dir $USERPROFILE/scoop/persist/vscodium/data/user-data
else
    set vscode_config_dir $APPDATA/Code
end

hc_safe_symlink_native $my_config_dir/settings.json $vscode_config_dir/User/settings.json
hc_safe_symlink_native $my_config_dir/keybindings.json $vscode_config_dir/User/keybindings.json
hc_safe_symlink_native $my_config_dir/snippets $vscode_config_dir/User/snippets

hc_safe_symlink $my_config_dir/fish/functions ~/.config/fish/functions

# ControlMaster is broken on Windows
if not set -q MSYSTEM
    hc_safe_symlink $my_config_dir/ssh_config ~/.ssh/config
end

if false && hc_doing "downloading lazygit to ~/.local/bin/lazygit"
    set dir (mktemp -d)
    cd $dir
    curl -Lo lazygit.tgz https://github.com/jesseduffield/lazygit/releases/download/v0.57.0/lazygit_0.57.0_linux_x86_64.tar.gz
    and tar -xf lazygit.tgz
    and mv -T lazygit $HOME/.local/bin/lazygit
    cd -
    rm -r $dir
end

if set -q MSYSTEM
    hc_safe_symlink_native $my_config_dir/keymapper.conf $USERPROFILE/keymapper.conf
else
    hc_safe_symlink $my_config_dir/keymapper.conf ~/.config/keymapper.conf
end
