#!/usr/bin/env bash

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install the Material Design theme for iTerm
open "${HOME}/.dotfile/init/material-design-colors.itermcolors"

#customizing zsh
brew install romkatv/powerlevel10k/powerlevel10k
echo 'source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >>~/.zshrc

rm -rf ~/.p10k.zsh
ln -s ~/.dotfile/init/.p10k.zsh ~/.p10k.zsh

# zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# Install fonts
open "${HOME}/.dotfile/init/MesloLGS NF Regular.ttf"
open "${HOME}/.dotfile/init/MesloLGS NF Italic.ttf"
open "${HOME}/.dotfile/init/MesloLGS NF Bold.ttf"
open "${HOME}/.dotfile/init/MesloLGS NF Bold Italic.ttf"

# vimrc settings
ln -s ~/.dotfile/init/.vimrc ~/.vimrc
