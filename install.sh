#!/bin/bash
# Enable oh-my-zsh and p10k
if [ -f "/bin/zsh" ]; then
  echo "### Zsh detected, setting up oh-my-zsh and powerlevel10k"
  sh ohmyzsh.sh --unattended
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi

# Create symlinks for all dotfiles and bin directory
echo "### Creating symlinks"
for f in .zshrc .zshenv .p10k.zsh .gitconfig .profile .bashrc .aliases.sh .banner.sh bin
do
  rm $HOME/$f 2> /dev/null
  ln -s $HOME/.dotfiles/$f $HOME/$f
done

# Clone my setup scripts
echo "### Cloning tools repo to $HOME/tools"
git clone https://github.com/benc-uk/ubuntu-tools-install.git $HOME/tools
