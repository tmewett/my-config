function sleep-until
	rtcwake -m mem -t (date -d $argv[1] +%s)
end
