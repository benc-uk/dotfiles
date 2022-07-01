#!/bin/bash

# Banner function
# usage: banner "message" <mode> <front emoji> <back emoji>
# mode can be "box" or empty string, emoji are optional, but should be a string with a single emoji
banner() {
  len=$((${#1} + 4))
  msg="$3 $1 $4"
  if [[ $3 != "" ]]; then len=$(( len + 2 )); fi
  if [[ $4 != "" ]]; then len=$(( len + 2 )); fi

  if [[ "$2" == "box" ]]; then
    echo -e "  \e[32m╔$(line "${len}" "═")╗"
    echo -e "  ║ \e[94m${msg}\e[32m ║"
    echo -e "  ╚$(line "$len" "═")╝"
    return
  fi

  echo -e "  \e[32m╭$(line "${len}")╮"
  echo -e "  │ \e[94m${msg}\e[32m │"
  echo -e "  ╰$(line "$len")╯"
}

line() {
  char=${2:-─}
  for (( i=0; i < $1; i++ )); do
    printf "$char"
  done
}

warning() {
  echo -e "\e[31m»»» ⛔ WARNING:\e[0m $1"
  read -p "Happy to proceed (y/N)? " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\e[38;5;63m»»» 😇 \e[36mOK exiting now. Bye!\n\e[0m" && exit 1 || return 1 
  fi
}

# banner "System Nuker 3000" "box" "💥" "💥"

# warning "This will destroy the universe!"