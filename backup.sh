#!/bin/bash

random_fruit() {
  fruits=("🍎" "🍊" "🍋" "🍌" "🍉" "🍇" "🍓" "🍒" "🍑" "🍍" "🥝" "🍅" "🍆" "🥑" "🥦" "🥒" "🥬" "🥭" "🥔" "🥕" "🌽" "🌶" "🍎" "🌶️" "🫐" "🥥" "🍄")
  echo "${fruits[$((RANDOM % ${#fruits[@]}))]}"
}

DIR="$( cd "$( dirname "$BASH_SOURCE" )" && pwd )"
cd "$DIR" || exit

echo -e "\e[34m»»» 📦 \e[32mBacking up dotfiles repo to GitHub\e[0m"

git add .
git commit -m "$(random_fruit) $(date)"
git push
