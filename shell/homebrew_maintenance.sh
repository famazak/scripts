#!/bin/bash

# Script to automate some Homebrew management

cd ~

# https://github.com/Homebrew/homebrew-cask/issues/102721
# to try and brute force around dock icons being removed
echo "#### Exporting dock config temp file"
defaults export com.apple.dock ".dock_temp"
echo "#### Dock config temp file exported!"

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

# to try and brute force around dock icons being removed
echo "#### Importing dock config..."
defaults import com.apple.dock ".dock_temp"
killall Dock
echo "#### Dock config re-imported"
