function cat --wraps=cat
    which bat > /dev/null
    and bat --paging=never $argv
    or command cat $argv
end
