.PHONY: install
install: # Install dotfiles
	@for file in $(shell find "$(CURDIR)/bash" -name ".*" -not -name ".git"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	unset file;
	@for file in $(shell find "$(CURDIR)/gnupg" -name "*.conf" -not -name ".git"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/.gnupg/$$f; \
	done; \
