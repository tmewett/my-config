function h
    sudo -u nobody -- $argv --help 2>&1 | less
    if functions -q $argv
        echo "There is also a function with this name - see 'functions $argv'"
    end
    if whatis $argv > /dev/null 2>&1
        echo "There are also manual pages for this command - try 'man $argv'"
    end
end
