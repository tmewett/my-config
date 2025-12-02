set my_config_dir (dirname (status filename))

if test -d /etc/apparmor.d
    hc_sudo_cp $my_config_dir/bwrap.apparmor /etc/apparmor.d/bwrap
end

hc_safe_symlink $my_config_dir/settings.json ~/.config/Code/User/settings.json
hc_safe_symlink $my_config_dir/keybindings.json ~/.config/Code/User/keybindings.json
hc_safe_symlink $my_config_dir/snippets ~/.config/Code/User/snippets

hc_safe_symlink $my_config_dir/fish/functions ~/.config/fish/functions
hc_safe_rm_symlink ~/.config/fish/conf.d

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
