#!/bin/sh

# Create symlinks for all dotfiles and bin directory
for f in .zshrc .zshenv .p10k.zsh .gitconfig .profile .bashrc .aliases.sh .secrets.sh .banner.sh bin
do
  rm $HOME/$f 2> /dev/null
  ln -s $HOME/.dotfiles/$f $HOME/$f
done
exit

# Enable oh-my-zsh and p10k
if test -f "/bin/zsh"; then
  sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi

# Clone my setup scripts
git clone https://github.com/benc-uk/ubuntu-tools-install.git $HOME/tools
