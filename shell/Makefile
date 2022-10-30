##############################################
# Homebrew maintenance

dock-export:
	defaults export com.apple.dock ~/.dock_temp && chmod 755 ~/.dock_temp

update:
	brew update

upgrade:
	brew upgrade --greedy

bundle:
	brew bundle dump --file=~/dotfiles/Brewfile --force

import-dock:
	defaults import com.apple.dock ~/.dock_temp && killall Dock

homebrew-maintenance: dock-export update upgrade bundle import-dock
