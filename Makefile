
all:
	(cd ~/.emacs.d && git pull)
	echo # rm -rf ~/.emacs.d/.local
	rm -rf ~/.emacs.d/.local/cache
	echo # rm -rf ~/.emacs.d/.local/cache/undo-tree-hist/
	echo # rm -rf ~/.emacs.d/.local/cache/projectile.cache
	(cd ~/.emacs.d && bin/doom sync)
	(cd ~/.emacs.d && bin/doom update)
	(cd ~/.emacs.d && bin/doom sync)
	(cd ~/.emacs.d && bin/doom doctor)

deps:
	npm -g install js-beautify
