function fish_title
	echo -n $_ ' '
	set cwd (string split / -- (prompt_pwd))
	echo -n $cwd[-1]
	for part in $cwd[-2..1]
		echo -n "\\$part"
	end
end
