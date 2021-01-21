#!/bin/bash

cd ~
echo "Updating & upgrading homebrew..."
/usr/local/bin/brew update && /usr/local/bin/brew upgrade --greedy && echo "homebrew successfully updated and upgraded"