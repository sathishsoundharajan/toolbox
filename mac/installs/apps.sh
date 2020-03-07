#!/bin/bash

# get application installed status
is_app_installed() {
	local installed=$(osascript -e "id of application \"$1\"" 2>/dev/null)
	echo "$installed"
}

####################################
# Setup iterm2 Terminal
####################################

setup_iterm2_terminal() {
	local installed=$(is_app_installed "iterm2")
	if [[ -z $installed ]]; then
		error "iTerm2 not found, installing through brew"

		brew cask install iterm2

		if ! command -v zsh 2>&1 >/dev/null; then
			error "zsh (shell) not found, installing.."
			brew install zsh
		fi

		info "installing oh-my-zsh.."
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

		## install tree
		if ! command -v tree 2>&1 >/dev/null; then
			error "tree not found, installing tree.."
			brew install tree
		fi

		info "installing powerlevel9k"
		rm -rf ~/.oh-my-zsh/custom/themes/powerlevel9k
		git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

		info "installing antigen ohmyzsh plugin manager"
		mkdir -p ~/.antigen
		curl -L git.io/antigen >~/.antigen/antigen.zsh

		info "download the template"
		mkdir -p ~/.zsh-template/
		curl -L https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/templates/zshrc.zsh-template >~/.zsh-template/zshrc.zsh-template

		info "moving ghostwheel zsh theme"
		mkdir -p ~/.zsh-themes
		cp ./mac/templates/ghostwheel.theme ~/.zsh-themes/ghostwheel.theme

		info "applying zshrc template"
		cat ~/.zsh-template/zshrc.zsh-template ./mac/templates/.zshrc >~/.zshrc

		info "installing fonts"
		brew tap homebrew/cask-fonts || error "Already insatalled"
		brew cask install font-hack-nerd-font || error "Already insatalled"
	fi

}

####################################
# Setup vim
####################################

setup_vim() {
	local installed=$(command_exists vim)
	if [[ -z $installed ]]; then
		error "vim not found, installing through brew"

		info "installing vim"
		brew install vim
	fi

	info "setting up the vim runtime"
	rm -rf ~/.vim_runtime
	git clone https://github.com/amix/vimrc.git ~/.vim_runtime

	sh ~/.vim_runtime/install_awesome_vimrc.sh
}
