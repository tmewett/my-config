function cat --wraps=cat
    type -q bat
    and bat --paging=never $argv
    or command cat $argv
end
