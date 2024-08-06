function suspend-process
    set pid (xprop | awk '/PID/ {print $3}')
    or return
    kill -s 19 $pid
    echo "Press Enter to resume"
    read -p ""
    kill -s 18 $pid
end
