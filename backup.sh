#!/bin/bash

cd "$HOME"/dotfiles || exit

echo -e "\e[34m»»» 📦 \e[32mBacking up dotfiles repo to GitHub\e[0m"

git add .
git commit -m "🍉 $(date)"
git push
