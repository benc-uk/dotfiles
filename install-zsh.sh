#!/bin/sh

#
# Simple script to install zsh and try to change default shell to it
#

if which sudo > /dev/null; then
  sudo apt update -qq
  sudo apt install -y zsh
else
  apt update -qq
  apt install -y zsh
fi

echo "💠💠💠 NOTE! To change the default shell run: chsh -s /usr/bin/zsh \$USER"
echo "💠💠💠 NOTE! This may prompt for a password 😥"
