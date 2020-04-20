SHELL=/bin/bash
$(eval DOTFILES_DIR:=$(if $(DOTFILES_DIR),$(DOTFILES_DIR),${HOME}/.dotfiles))
$(eval XDG_CONFIG_HOME:=$(if $(XDG_CONFIG_HOME),$(XDG_CONFIG_HOME),${HOME}/.dotfiles))


minimum: zsh_initialize vim_initialize tmux_initialize direnv_initialize 
	@echo "Finished minimum installation of .dotfiles"


all: minimum brew_bundle conda_install
	@echo "Finished installation of brew and conda"


test: minimum update clean
	@echo "Test Finished!"

zsh_initialize:
	@if [[ -e ${HOME}/.zshrc ]]; then \
		cp ${HOME}/.zshrc ${HOME}/.zshrc.backup; \
	fi
	@echo "source ${DOTFILES_DIR}/zsh/shared" >> ${HOME}/.zshrc


vim_initialize: xdg_config
	@if [[ -e ${HOME}/.vimrc ]]; then \
		mv ${HOME}/.vimrc ${HOME}/.vimrc.backup; \
	fi
	@ln -sfv ${DOTFILES_DIR}/nvim/init.vim ${HOME}/.vimrc
	@mkdir -p ${XDG_CONFIG_HOME}/nvim
	@ln -sfv ${DOTFILES_DIR}/nvim/init.vim ${XDG_CONFIG_HOME}/nvim/init.vim
	@ln -sfv ${DOTFILES_DIR}/dein ${XDG_CONFIG_HOME}/dein


xdg_config:
	@echo "export XDG_CONFIG_HOME=${XDG_CONFIG_HOME}" >> ${HOME}/.zshrc


tmux_initialize:
	@ln -sfv ${DOTFILES_DIR}/.tmux.conf ${HOME}/.tmux.conf


direnv_initialize:
	@ln -sfv ${DOTFILES_DIR}/.direnvrc ${HOME}/.direnvrc


clean:
	@if [[ -e ${HOME}/.zshrc.backup ]]; then \
		mv ${HOME}/.zshrc.backup ${HOME}/.zshrc;\
	fi
	@if [[ -e ${HOME}/.vimrc.backup ]]; then \
		mv ${HOME}/.vimrc.backup ${HOME}/.vimrc;\
	fi
	@rm -rf ${XDG_CONFIG_DIR}/nvim ${XDG_CONFIG_DIR}/dein

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
