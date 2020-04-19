SHELL=/bin/bash
#DOTFILES_DIR=${HOME}/.dotfiles
$(eval DOTFILES_DIR:=$(if $(DOTFILES_DIR),$(DOTFILES_DIR),${HOME}/.dotfiles))
XDG_CONFIG_HOME_=${XDG_CONFIG_HOME}

minimum: zsh_initialize vim_initialize tmux_initialize direnv_initialize 
	@echo "Finished minimum installation of .dotfiles"

all: minimum brew_bundle conda_install
	@echo "Finished installation of brew and conda"

zsh_initialize:
	@if [[ -e ${HOME}/.zshrc ]]; then \
		cp ${HOME}/.zshrc ${HOME}/.zshrc.backup; \
	fi
	@echo "source ${DOTFILES_DIR}/zsh/shared" >> ${HOME}/.zshrc
	@ln -sfv ${DOTFILES_DIR}/zsh/pure/pure.zsh ${DOTFILES_DIR}/zsh/prompt_pure_setup
	@ln -sfv ${DOTFILES_DIR}/zsh/pure/async.zsh ${DOTFILES_DIR}/zsh/async


vim_initialize: xdg_config
	@if [[ -e ${HOME}/.vimrc ]]; then \
		mv ${HOME}/.vimrc ${HOME}/.vimrc.backup; \
	fi
	@ln -sfv ${DOTFILES_DIR}/nvim/init.vim ${HOME}/.vimrc
	@mkdir -p ${XDG_CONFIG_HOME_}/nvim
	@ln -sfv ${DOTFILES_DIR}/nvim/init.vim ${XDG_CONFIG_HOME_}/nvim/init.vim
	@ln -sfv ${DOTFILES_DIR}/dein ${XDG_CONFIG_HOME_}/dein


xdg_config:
	$(eval XDG_CONFIG_HOME_:=$(if $(XDG_CONFIG_HOME_),$(XDG_CONFIG_HOME_),${HOME}/.config))
	@echo "export XDG_CONFIG_HOME=${XDG_CONFIG_HOME_}" >> ${HOME}/.zshrc


tmux_initialize:
	@ln -sfv ${DOTFILES_DIR}/.tmux.conf ${HOME}/.tmux.conf


direnv_initialize:
	@ln -sfv ${DOTFILES_DIR}/.direnvrc ${HOME}/.direnvrc


update:
	@git pull && git submodule update --init --recursive --remote


brew_install:
	@/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"


brew_bundle: brew_install
	@brew bundle


conda_install:
	@if [[ "$$(uname)" == 'Darwin' ]]; then \
    	URL="https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh"; \
	else \
    	URL="https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh"; \
	fi \
	&& wget $${URL} -O miniconda.sh \
	&& bash miniconda.sh -b -p ${HOME}/.miniconda \
	&& touch ${HOME}/.zshrc_ \
	&& echo export PATH="${HOME}/.miniconda/bin:$${PATH}" >> $${HOME}/.zshrc \
	&& rm miniconda.sh
