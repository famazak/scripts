#!/bin/bash

# Script to automate some Homebrew management

cd ~

echo "#### Updating Homebrew..."
brew update
echo "#### Homebrew successfully updated!"

echo "#### Upgrading Homebrew packages and casks...(may be prompted for password)"
brew upgrade --greedy
echo "### Homebrew pacakages and casks successfully upgraded!"

# Generate a new Brewfile 
echo "#### Generating Brewfile..."
brew bundle dump --file=~/dotfiles/Brewfile --force
echo "#### Brewfile successfully generated!"
