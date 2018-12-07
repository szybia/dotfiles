.PHONY: install
install: # Install dotfiles
	@for file in $(shell find "$(CURDIR)/bash" -name ".*"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	unset file;
	@for file in $(shell find "$(CURDIR)/gnupg" -name "*.conf"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/.gnupg/$$f; \
	done; \
