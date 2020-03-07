#!/bin/bash

# Main setup file for mac os

mac_setup() {
  if ! command -v ruby 2>&1 >/dev/null; then
    info "ruby required, install ruby!"
    return
  fi

  info "installed ruby :: " $(ruby --version)

  if ! command -v brew 2>&1 >/dev/null; then
    info "brew required, installing brew!"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  info "installed brew :: " $(brew --version)

	brew tap caskroom/cask

  setup_iterm2_terminal
	setup_vim
}
