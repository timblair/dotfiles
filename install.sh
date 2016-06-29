#!/bin/bash

if !(hash brew 2>/dev/null); then
  echo "Homebrew must be installed"
  exit 1
fi

# Install rcm for dotfiles management
brew tap thoughtbot/formulae
brew install rcm

# Set up my dotfiles
git clone git@github.com:timblair/dotfiles.git ~/.dotfiles
rcup -x README.md -x install.sh

# Set up apps etc using Homebrew bundle
brew tap Homebrew/bundle
brew bundle "$HOME/.Brewfile"
brew cleanup
brew cask cleanup
