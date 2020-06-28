
all:
	rm -rf ~/.emacs.d/.local/cache/undo-tree-hist/
	(cd ~/.emacs.d && bin/doom sync)
	(cd ~/.emacs.d && bin/doom update)
	(cd ~/.emacs.d && bin/doom sync)
