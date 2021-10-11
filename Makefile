amend:
	git add .
	git commit --amend -C HEAD

push:
	git add .
	git commit -m "Sync"
	git push

pull:
	git pull --rebase --autostash

sync: pull push
