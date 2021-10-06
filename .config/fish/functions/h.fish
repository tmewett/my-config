function h
    set thing $argv

    if test $thing = "--short"
        begin
            echo "Ctrl-c  Cancel"
            echo "Ctrl-d  Quit / stop input"
            echo "'h COMMAND'  Command help"
            echo "↑↓  Command history"
            echo "Alt-←→  Skip words"
            echo "Alt-Bksp  Delete word"
        end | column
    else
        if set -q _NUI_GRAPHICAL; and test $NUI_H_NEW_TERMINAL = true
            # We won't inherit any temp functions in a new terminal
            in-terminal fish -c "$thing --help 2>&1 | less -R"
        else
            $thing --help 2>&1 | less -R
        end

        set the_type (type -t $thing)
        if test "$the_type" = builtin
            echo "This command is a builtin - see 'help $thing'"
            help $thing
        else if test "$the_type" = function
            echo "This command is a function - see 'functions $thing'"
        end
        if whatis -- $thing > /dev/null 2>&1
            echo "There are also manual pages for this command - see 'man $thing'"
        end
    end
end
