SHELL = /bin/sh

.DEFAULT_GOAL := test

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
	@sudo ln -sfn $(CURDIR)/urxvt/ext/urxvt-font-size/font-size /usr/lib/urxvt/perl/font-size
	@# xinit
	@ln -sfn $(CURDIR)/.xinitrc $(HOME)/.xinitrc
	@# git
	@ln -sfn $(CURDIR)/.gitconfig $(HOME)/.gitconfig
	@#	vim
	@ln -sfn $(CURDIR)/vim/.vimrc $(HOME)/.vimrc
	@mkdir -p $(HOME)/.vim/backup
	@mkdir -p $(HOME)/.vim/bundle
	@mkdir -p $(HOME)/.vim/swapfiles
	@mkdir -p $(HOME)/.vim/undodir
	@if [ ! -d $(HOME)/.vim/bundle/Vundle.vim ]; then \
		git clone https://github.com/VundleVim/Vundle.vim.git $(HOME)/.vim/bundle/Vundle.vim; \
	fi;
	@if hash pip &>/dev/null; then \
		sudo pip install neovim; \
		sudo pip install greenlet==0.4.10; \
	fi;
	@if hash go &>/dev/null; then \
		go get -u github.com/mdempsky/gocode; \
	fi;
	@#	cleanup
	@unset file;


.PHONY: test
test: shellcheck


# if this session isn't interactive, then we don't want to allocate a
# TTY, which would fail, but if it is interactive, we do want to attach
# so that the user can send e.g. ^C through.
INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
ifeq ($(INTERACTIVE), 1)
	DOCKER_FLAGS += -t
endif


.PHONY: shellcheck
shellcheck:
	docker run --rm -i $(DOCKER_FLAGS) \
		--name dotfiles_shellcheck \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		bialkowskisz/shellcheck ./test.sh
