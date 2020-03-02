#!/bin/bash

. $(dirname "$0")/installs/apps.sh

# Main setup file for mac os

if ! command -v ruby 2>&1 >/dev/null; then
  echo "ruby required, install ruby!"
  return;
fi

echo "installed ruby :: " $(ruby --version)

if ! command -v brew 2>&1 >/dev/null; then
  echo "brew required, installing brew!"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "installed brew :: " $(brew --version)

setup_iterm2_terminal