# .dotfiles
## basics

```
cd $HOME
git clone --recursive https://github.com/moskomule/.dotfiles.git
cd .dotfiles
./setup.sh
```

Maybe you need `gut submodule update --init --recursive`

### zsh
write machine specific settings in `~/.zshrc_`

### vim
Changed to set `$XDG_CONFIG_HOME` from `~/.config` to this directory.

Installing nvim for Ubuntu 16.04 is 

```
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
pip install neovim
```

### tmux
`.tmux.conf` is for tmux 2.1 or later. Settings for mouse had been changed.

## Python
`bash ./getconda.sh` downloads and installs latest miniconda in `~/.miniconda`

## scripts

* imgcat: show image on iTerm2
* docker-cleaner: unused Docker containers and images
* jup2pdf: jupyter notebook to PDF using lualatex
* mkproj: make a (machine learning) project directory
