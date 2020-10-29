#!/bin.sh

#
# Simple script to install zsh and try to change default shell to it
#

sudo apt update
sudo apt install -y zsh
chsh -s /usr/bin/zsh $USER
