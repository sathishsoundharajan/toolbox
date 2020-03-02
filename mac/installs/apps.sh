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
    echo "iTerm2 not found, installing through brew"

    brew cask install iterm2

    if ! command -v zsh 2>&1 >/dev/null; then
      echo "zsh (shell) not found, installing.."
      brew install zsh
    fi

    echo "installing oh-my-zsh.."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    ## change shell to zsh
    chsh -s $(which zsh)

    ## install tree
    if ! command -v tree 2>&1 >/dev/null; then
      echo "tree not found, installing tree.."
      brew install tree
    fi

  fi

}
