function fish_prompt
    set -l last_command_exit_status $status

    test "$USER" = 'root'
    and echo (set_color red)"#"

    echo -n "$USER"
	test $SSH_TTY
    and printf '@'(prompt_hostname)

    echo -n " "(set_color green)(prompt_pwd)

    # Indicate a non-zero exit - have it inline so the prompt doesn't change width
    if test $last_command_exit_status -ne 0
        echo -n (set_color red)"!"
    else
        echo -n " "
    end

    echo -n (set_color normal)'$ '
end
