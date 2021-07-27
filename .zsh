#!/usr/bin/env bash

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install the Material Design theme for iTerm
open "${HOME}.dotfile/init/material-design-colors.itermcolors"

#customizing zsh
brew install romkatv/powerlevel10k/powerlevel10k
echo 'source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >>~/.zshrc

ln -s ~/.dotfile/init/.p10k.zsh ~/.p10k.zsh
