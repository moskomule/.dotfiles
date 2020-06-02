SHELL=/bin/bash
$(eval DOTFILES_DIR:=$(if $(DOTFILES_DIR),$(DOTFILES_DIR),${HOME}/.dotfiles))
$(eval XDG_CONFIG_HOME:=$(if $(XDG_CONFIG_HOME),$(XDG_CONFIG_HOME),${HOME}/.config))

# functions
define _backup
	if [[ -e ${1} ]]; then \
		cp ${1} ${1}.backup ; \
	fi
endef

define _remove_and_restore_backup
	if [[ -e ${1} ]]; then \
		rm -rf ${1}; \
	fi

	if [[ -e ${1}.backup ]]; then \
		mv ${1}.backup ${1} ; \
	fi
endef


# auto help https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
     
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

minimum: zsh_initialize misc_initialize vim_initialize tmux_initialize ## Minimum Installation
	@echo "Finished minimum installation of .dotfiles"


all: brew_install brew_bundle conda_install minimum ## Install all, including **brew and conda
	@echo "Finished installation of brew and conda"


test: minimum update clean ## minimum installation, update and clean for test purpose
	@echo ${HOME}
	@echo ${DOTFILES_DIR}
	@echo "Test Finished!"

zsh_initialize: ## initialize zsh files
	@$(call _backup,${HOME}/.zshrc)
	@echo "source ${DOTFILES_DIR}/zsh/shared" >> ${HOME}/.zshrc


vim_initialize: xdg_config ## initialize vim files
	@$(call _backup,${HOME}/.vimrc)
	@ln -sfv ${DOTFILES_DIR}/nvim/init.vim ${HOME}/.vimrc
	@mkdir -p ${XDG_CONFIG_HOME}/nvim
	@ln -sfv ${DOTFILES_DIR}/nvim/init.vim ${XDG_CONFIG_HOME}/nvim/init.vim
	@ln -sfv ${DOTFILES_DIR}/dein ${XDG_CONFIG_HOME}/dein
	@python -m venv venv \
		&& ${DOTFILES_DIR}/venv/bin/pip install -U pip \
		&& ${DOTFILES_DIR}/venv/bin/pip install -U pynvim


xdg_config: ## set xdg_config path
	@echo "export XDG_CONFIG_HOME=${XDG_CONFIG_HOME}" >> ${HOME}/.zshrc
	@echo "export XDG_CONFIG_HOME=${XDG_CONFIG_HOME}" >> ${HOME}/.bash_profile


tmux_initialize: ## set tmux files
	@ln -sfv ${DOTFILES_DIR}/.tmux.conf ${HOME}/.tmux.conf

ipython_initialize: ## set ipython config
	@mkdir -p ${HOME}/.ipython/profile_default
	@ln -sfv ${DOTFILES_DIR}/ipython/ipython_config.py ${HOME}/.ipython/profile_default

misc_initialize: ## set direnv, rsync
	@$(call _backup,${HOME}/.rsync_exclude)
	@ln -sfv ${DOTFILES_DIR}/misc/.rsync_exclude ${HOME}/.rsync_exclude
	@$(call _backup,${HOME}/.direnvrc)
	@ln -sfv ${DOTFILES_DIR}/.direnvrc ${HOME}/.direnvrc
	@$(call _backup,${HOME}/.bash_profile)


clean: ## cleanup
	@$(call _remove_and_restore_backup,${HOME}/.zshrc)
	@$(call _remove_and_restore_backup,${HOME}/.vimrc)
	@$(call _remove_and_restore_backup,${HOME}/.bash_profile)
	@$(call _remove_and_restore_backup,${HOME}/.tmux.conf)
	@$(call _remove_and_restore_backup,${HOME}/.direnvrc)
	@$(call _remove_and_restore_backup,${HOME}/.rsync_exclude)
	@rm -rf ${XDG_CONFIG_DIR}/nvim ${XDG_CONFIG_DIR}/dein
	@echo "Cleaned!"


update: ## update dotfiles
	@git pull && git submodule update --init --recursive --remote
	@${DOTFILES_DIR}/venv/bin/pip install -U pip pynvim


brew_install:
	@if [[ "$$(uname)" == 'Darwin' ]]; then \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"; \
	else \
	# https://docs.brew.sh/Homebrew-on-Linux#alternative-installation
		git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew && \
		mkdir ~/.linuxbrew/bin && \
		ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin && \
		eval $(~/.linuxbrew/bin/brew shellenv);
	fi


brew_bundle: 
	@brew bundle


conda_install:
	@if [[ "$$(uname)" == 'Darwin' ]]; then \
    	URL="https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh"; \
	else \
    	URL="https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh"; \
	fi \
	&& wget $${URL} -O miniconda.sh \
	&& bash miniconda.sh -b -p ${HOME}/.miniconda \
	&& echo export PATH="${HOME}/.miniconda/bin:$${PATH}" >> $${HOME}/.zshrc \
	&& echo export PATH="${HOME}/.miniconda/bin:$${PATH}" >> $${HOME}/.bash_profile \
	&& rm miniconda.sh
