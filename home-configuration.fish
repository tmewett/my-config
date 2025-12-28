set my_config_dir (dirname (status filename))

hc_safe_symlink $my_config_dir/settings.json ~/.config/Code/User/settings.json
hc_safe_symlink $my_config_dir/keybindings.json ~/.config/Code/User/keybindings.json
hc_safe_symlink $my_config_dir/snippets ~/.config/Code/User/snippets

hc_safe_symlink $my_config_dir/fish/functions ~/.config/fish/functions

if test ! -e ~/.local/bin/lazygit && hc_doing "downloading lazygit to ~/.local/bin/lazygit"
    set dir (mktemp -d)
    cd $dir
    curl -Lo lazygit.tgz https://github.com/jesseduffield/lazygit/releases/download/v0.57.0/lazygit_0.57.0_linux_x86_64.tar.gz
    and tar -xf lazygit.tgz
    and mv -T lazygit $HOME/.local/bin/lazygit
    cd -
    rm -r $dir
end

set keymapper_conf ~/.config/keymapper.conf
hc_safe_symlink $my_config_dir/keymapper.conf $keymapper_conf

if false #hc_doing "writing $keymapper_conf"
    function shorthand -a code exp
        echo "Backslash $code !250ms Period >> \"$exp.\""
        echo "Backslash $code !250ms Comma >> \"$exp,\""
        echo "Backslash $code >> \"$exp \""
    end
    begin
        cat $my_config_dir/keymapper.conf
        # shorthand "A" and
        # shorthand "B" but
        # shorthand "C" can
        # shorthand "D" don\'t
        # shorthand "F" for
        # shorthand "G" going
        # shorthand "H" have
        # shorthand "I" I
        # shorthand "J" just
        # shorthand "K" know
        # shorthand "L" like
        # shorthand "M" from
        # shorthand "N" not
        # shorthand "O" out
        # shorthand "P" people
        # shorthand "T" the
        # shorthand "W" with
        # shorthand "Y" you
        # shorthand "A B" about
        # shorthand "A F" after
        # shorthand "B C" because
        # shorthand "C D" could
        # shorthand "C N" couldn\'t
        # shorthand "D S" doesn\'t
        # shorthand "I M" I\'m
        # shorthand "I O" into
        # shorthand "I V" I\'ve
        # shorthand "O V" over
        # shorthand "T N" then
        # shorthand "T Z" these
        # shorthand "W D" would
        # shorthand "W N" wouldn\'t
        # shorthand "W O" without
    end > $keymapper_conf
end
