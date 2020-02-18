
all:
	(cd ~/.emacs.d && bin/doom update)
	(cd ~/.emacs.d && bin/doom sync)
	(cd ~/.emacs.d && bin/doom refresh)
