#!/bin/bash
echo -e "\n\e[38;5;135m╭───────────────────────────────────────────╮"
echo -e "│\e[38;5;220m    Dotfiles, Oh My Zsh & P10k Installer \e[38;5;135m  │"
echo -e "╰───────────────────────────────────────────╯"
echo -e "\e[38;5;33mBen Coleman     \e[38;5;40mv0.0.2     🚀  🎁  💥\n"
echo -e "\e[38;5;214m»»» 🙉 This script will remove & replace many of your personal dotfiles"
echo -e "\e[38;5;214m»»» 🙊 If you have anything in these files/folders, please back them up:"
echo -e "\e[38;5;214m»»» 🙈   \e[38;5;227m.zshrc .zshenv .bashenv .p10k.zsh .gitconfig .profile .bashrc ~/bin/ ~/tools/ ~/.oh-my-zsh"
echo -e "\e[38;5;214m»»» 🐵 Only continue with this script when it is ok to overwrite these files...\n\e[0m"

PROMPT="1"
if [[ $1 == "noprompt" ]]; then
  PROMPT="0"
fi
if [[ -f /.dockerenv ]]; then
  PROMPT="0"
fi

if [[ "$PROMPT" == "1" ]]; then
  read -p "Are you sure? " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      [[ "$0" = "$BASH_SOURCE" ]] && echo -e "\e[38;5;63m»»» 😇 OK, exiting without making changes, bye!\n\e[0m" && exit 1 || return 1 
  fi
fi

#
# Enable oh-my-zsh and p10k
#
if [ -f "/bin/zsh" ]; then
  echo -e "\e[38;5;45m»»» Zsh detected, setting up oh-my-zsh and powerlevel10k \e[0m"
  rm -rf $HOME/.oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
  touch $HOME/.z
fi

#
# Create symlinks for all dotfiles and bin directory
#
echo -e "\n\e[38;5;45m»»» Creating dotfile symlinks \e[0m"
for f in .zshrc .p10k.zsh .gitconfig .profile .bashrc .aliases.rc .banner.rc bin
do
  echo $f
  rm $HOME/$f 2> /dev/null
  ln -s $HOME/dotfiles/$f $HOME/$f
done
rm $HOME/.bashenv $HOME/.zshenv
ln -s $HOME/dotfiles/.env.rc $HOME/.bashenv
ln -s $HOME/dotfiles/.env.rc $HOME/.zshenv

#
# Clone my setup scripts
#
echo -e "\n\e[38;5;45m»»» Cloning tools repo to $HOME/tools \e[0m"
rm -rf $HOME/tools
git clone -q https://github.com/benc-uk/tools-install.git $HOME/tools
