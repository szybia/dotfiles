SHELL = /bin/sh

.DEFAULT_GOAL := test

.PHONY: install
install: bash gpg i3 urxvt tmux xinit git ssh vim arch ranger


.PHONY: bash
bash:
	@for file in $(shell find "$(CURDIR)/bash" -name ".*"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done;
	@unset file;

.PHONY: gpg
gpg:
	@mkdir -p $(HOME)/.gnupg
	@for file in $(shell find "$(CURDIR)/gnupg" -name "*.conf"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/.gnupg/$$f; \
	done;
	@unset file;

.PHONY: i3
i3:
	@mkdir -p $(HOME)/.config/i3/
	@for file in $(shell find "$(CURDIR)/i3" -name "*conf*"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/.config/i3/$$f; \
	done;
	@unset file;
	@mkdir -p ~/pictures/screenshots/

.PHONY: urxvt
urxvt:
	@ln -sfn $(CURDIR)/urxvt/.Xdefaults $(HOME)/.Xdefaults
	@mkdir -p /usr/lib/urxvt/perl/
	@sudo ln -sfn $(CURDIR)/urxvt/ext/clipboard /usr/lib/urxvt/perl/clipboard
	@sudo ln -sfn $(CURDIR)/urxvt/ext/urxvt-font-size/font-size /usr/lib/urxvt/perl/font-size

.PHONY: tmux
tmux:
	@ln -sfn $(CURDIR)/tmux/.tmux.conf $(HOME)/.tmux.conf

.PHONY: xinit
xinit:
	@ln -sfn $(CURDIR)/.xinitrc $(HOME)/.xinitrc

.PHONY: git
git:
	@ln -sfn $(CURDIR)/.gitconfig $(HOME)/.gitconfig

.PHONY: ssh
ssh:
	@mkdir -p $(HOME)/.ssh
	@ln -sfn $(CURDIR)/ssh/ssh-find-agent/ssh-find-agent.sh  $(HOME)/.ssh-find-agent.sh

.PHONY: vim
vim:
	@ln -sfn $(CURDIR)/vim/.vimrc $(HOME)/.vimrc
	@mkdir -p $(HOME)/.vim/backup
	@mkdir -p $(HOME)/.vim/bundle
	@mkdir -p $(HOME)/.vim/swapfiles
	@mkdir -p $(HOME)/.vim/undodir

.PHONY: arch
arch:
	@sudo ln -sfn $(CURDIR)/arch/hooks/update_pkg_list.hook \
							/usr/share/libalpm/hooks/update_pkg_list.hook
	@#	Parcimonie GPG key refreshing
	@sudo ln -sfn $(CURDIR)/arch/parcimonie/s.conf \
							/etc/parcimonie.sh.d/s.conf
	@sudo ln -sfn $(CURDIR)/arch/parcimonie/user.conf \
							/etc/systemd/system/parcimonie.sh@s.service.d/user.conf
	@mkdir -p $(HOME)/.local/tmp/parcimonie
	#	systemctl daemon-reload
	#	systemctl cat parcimonie.sh@julian.service
	# 	systemctl enable parcimonie.sh@julian.service
	# 	systemctl start parcimonie.sh@julian.service
	# 	systemctl status parcimonie.sh@julian.service

.PHONY: ranger
ranger:
	@mkdir -p $(HOME)/.config/ranger
	@ln -sfn $(CURDIR)/ranger/rc.conf $(HOME)/.config/ranger/
	@ln -sfn $(CURDIR)/ranger/rifle $(HOME)/.config/ranger/


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
		szybia/shellcheck ./test.sh
