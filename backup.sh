#!/bin/bash

DIR="$( cd "$( dirname "$BASH_SOURCE" )" && pwd )"
cd "$DIR" || exit

echo -e "\e[34m»»» 📦 \e[32mBacking up dotfiles repo to GitHub\e[0m"

git add .
git commit -m "🍉 $(date)"
git push
