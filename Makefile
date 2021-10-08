save:
	git add .
	git commit -m "Sync"

amend:
	git add .
	git commit --amend -C HEAD

push: save
	git push

pull:
	git pull --rebase --autostash

sync:
	git pull --rebase --autostash
	git add .
	git commit -m "Sync"
	git push
