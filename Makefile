hostname := $(shell hostname)
ifeq ($(hostname),ct-lt-3236)
pkgapply_packages_file := $(HOME)/packages.txt
watchexec := x
lazygit := x
endif

configure:

ifdef pkgapply_packages_file
vars/_last_pkgapply: vars $(pkgapply_packages_file)
	sudo ./pkgapply $(pkgapply_packages_file)
	touch $@
configure: vars/_last_pkgapply
endif

ifdef watchexec
_watchexec_version := 2.3.2
$(HOME)/.local/bin/watchexec: vars/_watchexec_version
	dir="$$(mktemp -d)" && \
		( curl -L https://github.com/watchexec/watchexec/releases/download/v$(_watchexec_version)/watchexec-$(_watchexec_version)-x86_64-unknown-linux-musl.tar.xz | tar -m -C $$dir -J --strip-components=1 -x ) \
		&& mv $$dir/watchexec $@ \
		&& rm -r $$dir
configure: $(HOME)/.local/bin/watchexec
endif

ifdef lazygit
_lazygit_version := 0.52.0
$(HOME)/.local/bin/lazygit: vars/_lazygit_version
	dir="$$(mktemp -d)" && \
		( curl -L https://github.com/jesseduffield/lazygit/releases/download/v$(_lazygit_version)/lazygit_$(_lazygit_version)_Linux_x86_64.tar.gz | tar -m -C $$dir -z -x ) \
		&& mv $$dir/lazygit $@ \
		&& rm -r $$dir
configure: $(HOME)/.local/bin/lazygit
endif

vars:
	mkdir vars
vars/%.tmp: FORCE | vars
	@echo '$(call escape,$($*))' > $@
# Write the value to a temporary file and only overwrite if it's different.
vars/%: vars/%.tmp | vars
	@if ! cmp --quiet vars/$*.tmp vars/$*; then cp vars/$*.tmp vars/$*; fi

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

.PHONY: FORCE
FORCE:
