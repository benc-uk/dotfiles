#!/bin/sh

for f in .zshrc .zshenv .p10k.zsh .gitconfig .profile .bashrc .myaliases .secrets.sh bin
do
  rm $HOME/$f > /dev/null
  ln -s $HOME/.dotfiles/$f $HOME/$f
done
