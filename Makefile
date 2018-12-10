SHELL = /bin/sh

.PHONY: install
install: # Install dotfiles
	@#	bash
	@for file in $(shell find "$(CURDIR)/bash" -name ".*"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done;
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
	@mkdir -p $(HOME)/.vim/backup
	@mkdir -p $(HOME)/.vim/bundle
	@mkdir -p $(HOME)/.vim/swapfiles
	@mkdir -p $(HOME)/.vim/undodir
	@if [ ! -d $(HOME)/.vim/bundle/Vundle.vim ]; then \
		git clone https://github.com/VundleVim/Vundle.vim.git $(HOME)/.vim/bundle/Vundle.vim; \
	fi;
	@#	cleanup
	@unset file;

.PHONY: shellcheck
shellcheck:
	docker run --rm -i \
		--name dotfiles_shellcheck \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		bialkowskisz/shellcheck ./test.sh
