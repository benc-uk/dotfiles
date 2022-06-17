#!/bin/bash

echo -e "\n\e[38;5;135m╭───────────────────────────────────────────╮"
echo -e "│\e[38;5;220m    Dotfiles, Oh My Zsh & P10k Installer \e[38;5;135m  │"
echo -e "╰───────────────────────────────────────────╯"
echo -e "\e[38;5;33mBen Coleman     \e[38;5;40mv1.0.6     🚀  🎁  💥\n"
echo -e "\e[38;5;214m»»» 🙉 This script will remove & replace many of your personal dotfiles"
echo -e "\e[38;5;214m»»» 🙊 If you have anything in these files/folders, please back them up:"
echo -e "\e[38;5;214m»»» 🙈   \e[38;5;227m.zshrc .zshenv .bashenv .p10k.zsh .gitconfig .profile .bashrc ~/bin/ ~/tools/ ~/.oh-my-zsh"
echo -e "\e[38;5;214m»»» 🐵 Only continue with this script when it is ok to overwrite these files...\n\e[0m"

# Need to use this as Codespaces clones the dotfile repo outside of $HOME
DOTFILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

PROMPT="1"
if [[ $1 == "noprompt" ]]; then
  PROMPT="0"
fi
if [[ -f /.dockerenv ]]; then
  PROMPT="0"
fi
if [[ $CODESPACES ]]; then
  PROMPT="0"
fi

if [[ "$PROMPT" == "1" ]]; then
  read -p "Happy to proceed? " -n 1 -r
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
  rm -rf "$HOME"/.oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME"/.oh-my-zsh/custom/themes/powerlevel10k
  touch "$HOME"/.z
fi

#
# Create symlinks for all dotfiles and bin directory
#
echo -e "\n\e[38;5;45m»»» Creating dotfile symlinks \e[0m"
for f in .zshrc .p10k.zsh .gitconfig .profile .bashrc .aliases.rc .banner.rc bin
do
  echo -e "\e[38;5;45m»»» 📃  ~/$f --> $DOTFILE_DIR/$f"
  rm -rf "$HOME"/$f
  ln -s "$DOTFILE_DIR"/$f "$HOME"/$f
done

# Create symlinks for env file, depending on zsh or bash
rm -f "$HOME"/.bashenv "$HOME"/.zshenv
echo -e "\e[38;5;45m»»» 📃  ~/.bashenv --> $DOTFILE_DIR/.env.rc "
ln -s "$DOTFILE_DIR"/.env.rc "$HOME"/.bashenv
echo -e "\e[38;5;45m»»» 📃  ~/.zshenv --> $DOTFILE_DIR/.env.rc "
ln -s "$DOTFILE_DIR"/.env.rc "$HOME"/.zshenv

# if .local.rc doesn't exist, create it
if [ ! -f "$HOME"/.local.rc ]; then
  echo -e "\e[38;5;45m»»» Creating ~/.local.rc \e[0m"
  echo "# Put local overrides and other customizations here. These can be secrets, etc." > "$HOME"/.local.rc
fi

#
# Clone my setup scripts
#
echo -e "\n\e[38;5;45m»»» Cloning tools repo to $HOME/tools \e[0m"
rm -rf "$HOME"/tools
git clone -q https://github.com/benc-uk/tools-install.git "$HOME"/tools

#
# zsh plugins
#
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
