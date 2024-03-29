#!/usr/bin/env bash

# BREW APPS
# ------------------------------------------------------------------------------
declare -a BREW_APPS=(
  tree
  ack
  httpie
  awscli
  # SAM
  aws-sam-cli
  gh
  git
  htop
  jq
  ssh-copy-id
  screen
  node
  nvm
  wget
  # file reader
  # https://github.com/sharkdp/bat
  bat
  # git delta
  # https://github.com/dandavison/delta
  git-delta
  # log viwer
  # https://lnav.org/downloads
  lnav
  # lazygit
  # https://github.com/jesseduffield/lazygit
  lazygit
  openssl
  openvpn
  tailscale
  vim
  yarn
  pyenv
  pyenv-virtualenv
  libjpeg
  # cannot compile the psycopg2 without postgresql
  postgresql
  zsh
  # you can specify version go@version
  #go@1.16
  # midnight-commander
  mc 
  # react native 
  cocoapods
  watchman
  # github action
  act
  # https://github.com/schollz/croc cool tool for sending files
  croc
  # httpie change
  rs/tap/curlie
  # restic
  restic
  # https://github.com/rakyll/hey
  hey
)

# BREW CASK APPS
# ------------------------------------------------------------------------------

declare -a BREW_CASK_APPS=(
  alfred
  docker
  dropbox
  firefox
  jetbrains-toolbox
  iterm2
  postman
  # https://rectangleapp.com/
  rectangle
  spotify
  visual-studio-code
  1password
  toggl-track
  protonvpn
  stats
  snagit
  tunnelblick
  vlc 
  flux
  slack
  textexpander
  the-unarchiver 
  charles
  grammarly
  zoom
  mimestream
  notion
  anki
  # Android IDE
  adoptopenjdk/openjdk/adoptopenjdk8
  # React debugger
  react-native-debugger
  # Figma
  figma
  # Raycast
  raycast
)

function install_brew_packages() {
  bot "Updating brew ..."

  # install homebrew
  if [[ $(command -v brew) == "" ]]; then
    bot "Installing brew ..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  
  # Make sure we’re using the latest Homebrew.
  brew update
  
  _install_brew_cask
  _install_brew
}


function _install_brew_cask() {
  bot "Checking brew cask packages ..."
  # Install HomeBrew casks
  brew tap homebrew/cask-versions
  brew tap aws/tap

  # Install brew cask packages
  for pkg in ${BREW_CASK_APPS[@]}; do
    if brew list --cask -1 | grep -q "^${pkg}"; then
      ok "[brew cask] Package '$pkg' is already installed"

      # Checking if the package needs update
      if brew outdated --cask --quiet | grep -q "^${pkg}"; then
        warn "[brew cask] Package '$pkg' is not up to date, updating it ..."
        brew reinstall --cask "$pkg"
      fi
    else
      warn "[brew cask] Package '$pkg' is not installed"
      brew install --cask "$pkg"
    fi
  done
  unset BREW_CASK_APPS

  ok "[brew cask] going to upgrade brew cask"
  brew upgrade --cask

  ok
}


# [Some brew commands]
# brew outdated -> list outdated packages
# brew upgrade -> upgrade all
# brew pin mysql -> keep mysql packages to the current version to avoid upgrading it
# brew upgrade mysql
function _install_brew() {
  bot "Checking brew packages ..."

  # Install brew packages
  for pkg in ${BREW_APPS[@]}; do
    if brew list --formula -1 | grep -q "^${pkg}\$"; then
      ok "[brew] Package '$pkg' is already installed"

      # Checking if the package needs update
      if brew outdated --quiet | grep -q "^${pkg}"; then
        warn "[brew] Package '$pkg' is not up to date, updating it ..."
        brew upgrade "$pkg"
      fi
    else
      warn "[brew] Package '$pkg' is not installed"
      brew install "$pkg"
    fi
  done
  unset BREW_APPS

  if vim --version | egrep -q '\-lua'; then
    error "[brew] Vim package installed without lua support. Lua support is needed for some plugins. Run:"
    error "brew unlink vim"
    error "brew install vim --with-lua"
  fi

  ok
}

source .echos
# Install brew packages
install_brew_packages
