function df --wraps=df
	# -h: human-readable sizes
	command df -h $argv
end
