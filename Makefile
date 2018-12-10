.PHONY: install
install: # Install dotfiles
	@#	bash
	@for file in $(shell find "$(CURDIR)/bash" -name ".*"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done;
	@source ~/.bashrc
	@#	gpg
	@mkdir -p $(HOME)/.gnupg
	@for file in $(shell find "$(CURDIR)/gnupg" -name "*.conf"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/.gnupg/$$f; \
	done;
	@#	i3
	@mkdir -p $(HOME)/.config/i3/
	@for file in $(shell find "$(CURDIR)/i3" -name "*conf*"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/.config/i3/$$f; \
	done;
	@#	urxvt
	@ln -sfn $(CURDIR)/urxvt/.Xdefaults $(HOME)/.Xdefaults
	@sudo ln -sfn $(CURDIR)/urxvt/ext/clipboard /usr/lib/urxvt/perl/clipboard
	@#	vim
	@ln -sfn $(CURDIR)/vim/.vimrc $(HOME)/.vimrc
	@mkdir -p ~/.vim/backup
	@mkdir -p ~/.vim/bundle
	@mkdir -p ~/.vim/swapfiles
	@mkdir -p ~/.vim/undodir
	@git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	@#	cleanup
	@unset file;
