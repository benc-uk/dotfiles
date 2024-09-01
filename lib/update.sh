#!/bin/bash

DIR="$( cd "$( dirname "$BASH_SOURCE" )" && pwd )"
cd "$DIR" || exit

echo -e "\e[34m»»» 💥 \e[32mUpdating dotfiles to latest on GitHub\e[0m"
echo -e "\e[34m»»» 💥 \e[32mLocal edits \e[31mWILL BE OVERWRITTEN! 😲\e[0m"

read -p "Are you sure? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo -e "\e[34m»»» 😇 \e[32mOK, exiting without making changes, bye!\n\e[0m" && exit 1 || return 1 
fi

git fetch --all
git reset --hard origin/master
