#!/bin/sh

#
# Simple script to install zsh and try to change default shell to it
#

sudo apt update -qq
sudo apt install -y zsh
echo "💠💠💠 NOTE! To change the default shell run: chsh -s /usr/bin/zsh \$USER"
echo "💠💠💠 NOTE! This may prompt for a password 😥"
