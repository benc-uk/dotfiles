#!/bin/sh

for f in .zshrc .zshenv .p10k.zsh .gitconfig .profile .bashrc .myaliases .secrets.sh bin
do
  rm $HOME/$f > /dev/null
  ln -s $HOME/.dotfiles/$f $HOME/$f
done

sudo apt install zsh
chsh -s /usr/bin/zsh $USER
sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
