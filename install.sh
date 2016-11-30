#!/bin/bash

# Tim's Development Environment Setup
# ===================================

# Stop immediately if anything fails
set -e

############################################
# Handy functions
############################################

function cecho() {
  color=1 && bold=0  # white and not bold
  if [ $# -ge "2" ]; then
    if   [ $2 == 'red'    ]; then color=31
    elif [ $2 == 'green'  ]; then color=32
    elif [ $2 == 'yellow' ]; then color=33
    elif [ $2 == 'blue'   ]; then color=34
    elif [ $2 == 'purple' ]; then color=35
    elif [ $2 == 'teal'   ]; then color=36
    else
      color="1"  # white
    fi
  fi
  if [ "$3" == 'bold' ]; then
    bold=1
  fi
  echo -e "[WLD "`date +"%T"`"] \033["$bold";"$color"m"$1"\033[0;0m"
}

function ruby_installed() {
  local rubies=(`rbenv versions`)
  for x in ${rubies[@]}; do
    if [ "$x" == "$1" ]; then
      return 0
    fi
  done
  return 1
}

function install_ruby() {
  if ! (ruby_installed "$1"); then
    cecho "Installing ruby $1"
    rbenv install $1 && rbenv shell $1
    gem update --system
  fi
}

############################################
# Validate pre-requisites
############################################

# OS X version (10.X...): 11 = El Capitan; 12 = Sierra
OSX_VERSION=`sw_vers -productVersion | cut -d. -f2`
if ! [[ " 11 12 " == *" $OSX_VERSION "* ]]; then
  cecho "Unknown OS X version: aborting." "red"
  exit 1
fi

############################################
# Ensure Xcode CLT installed for gcc
############################################

if ! [ -f "/Library/Developer/CommandLineTools/usr/bin/clang" ]; then
  cecho "Xcode Command Line Tools not installed" "red"
  if ( which xcode-select >/dev/null ); then
    read -p "Press return to install (expect a GUI popup)... "
    `xcode-select --install`
  else
    cecho "Please install via Xcode or from Apple's developer site" "blue"
    cecho "https://developer.apple.com/downloads/" "blue"
  fi
  cecho "Once installed, re-run this kickstart script" "blue"
  exit 1
fi

set +e; gcc --version >/dev/null 2>&1; status=$?; set -e
if [ "$status" -eq "69" ]; then
  cecho "Xcode license needs to be agreed to" "red"
  cecho "Run 'sudo xcodebuild -license' from your command line" "blue"
  cecho "Once you've agreed to the terms, re-run this kickstart script" "blue"
  exit 1
fi

############################################
# Core setup
############################################

if !(hash brew 2>/dev/null); then
  cecho "Installing Homebrew to /usr/local"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ ! -d "$HOME/.vim" ]; then
  cecho "Configuring Vim"
  bash < <(curl -fsSL https://raw.githubusercontent.com/timblair/vimfiles/master/install.sh)
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  cecho "Setting up Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

############################################
# Dotfiles and app bundles
############################################

if [ ! -d "$HOME/.dotfiles" ]; then
  git clone git@github.com:timblair/dotfiles.git ~/.dotfiles
fi

# Use rcm for dotfiles management
cecho "Setting up dotfiles"
brew tap thoughtbot/formulae
brew install rcm
rcup -x README.md -x install.sh

# Set up apps etc using Homebrew bundle
cecho "Setting up apps via Homebrew bundle"
brew tap Homebrew/bundle
brew bundle --global
brew cleanup
brew cask cleanup

# Run the script to set various options and defaults
cecho "Setting a big bunch of OS X config options"
"$HOME/.osx"

# Install Base16 colour scheme
if [ ! -d "$HOME/.config/base16-shell" ]; then
  cecho "Installing Base16 shell colour scheme"
  mkdir -p "$HOME/.config"
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi

############################################
# Ruby
############################################

cecho "Installing the latest Ruby version"

# El Capitan doesn't come with a linkable version of OpenSSL, so we need to
# install our own and ensure that all rubies + gems are built against it.
if [ "$OSX_VERSION" -eq 11 ]; then
  cecho "Ensuring Rubies build against Homebrew's OpenSSL"
  $( brew ls libyaml > /dev/null 2>&1 ) || brew install libyaml
  $( brew ls openssl > /dev/null 2>&1 ) || brew install openssl
  rbo_path=$(dirname ~/.rbenv/plugins/rbenv-homebrew-openssl/.)
  if [ ! -d $rbo_path ]; then
    git clone https://github.com/timblair/rbenv-homebrew-openssl.git $rbo_path
  fi
fi

# Default Ruby (latest stable)
$( which gsort >/dev/null ) || brew install coreutils # sorting version strings
RUBYV=$(ruby-build --definitions | grep -e "^\d.\d.\d\$" | gsort -V | tail -1)
install_ruby "$RUBYV"
rbenv global "$RUBYV"

############################################
# Other local setup
############################################

mkdir -p "$HOME/bin" "$HOME/go" "$HOME/tmp"

############################################
# That's it!
############################################

cecho "Setup complete" "green"
