#!/bin/bash

#
# Slow crude approximation to a Powerlevel-10k prompt, but for bash
#

PROMPT_COMMAND=__prompt_command

# Kubernetes prompt script I found
source $HOME/dotfiles/lib/kube-ps1.sh

function __git_color {
  local git_status="$(git status --porcelain  2> /dev/null | wc -l)"

  if (( $git_status > 0)); then
    echo -e "\[\e[38;5;220m\]" 
  else
    echo -e "\[\e[38;5;76m\]"
  fi
}

function __git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "$SEP🌳 $(__git_color)$branch"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "$SEP📜 $(__git_color)$commit"
  fi
}

function __azure_sub {
  # Don't use az account show as it's slow
  # We look directly into the cached config in ~/.azure
  regex='=\s(.*?)'
  if [[ -f $(which jq) && -f "$HOME/.azure/clouds.config" && $(cat $HOME/.azure/clouds.config) =~ $regex ]]; then
    azsub=$(cat $HOME/.azure/azureProfile.json | jq -r ".subscriptions[] | select(.id==\"${BASH_REMATCH[1]}\").name")
    echo "$SEP\[\e[38;5;15m\]⛅ \[\e[38;5;87m\]$azsub"
  fi
}

SEP=" \[\e[30m\]┃ "

KUBE_PS1_SEPARATOR=" "
KUBE_PS1_PREFIX="$SEP"
KUBE_PS1_SUFFIX=""
KUBE_PS1_SYMBOL_DEFAULT="🐳"
KUBE_PS1_CTX_COLOR="155"
KUBE_PS1_NS_COLOR="155"

# Build & return prompt 
__prompt_command() {
  local e="$?"
  # Start with user@host 
  PS1="\[\e[48;5;237m\] 🏠 \[\e[38;5;220m\]\u\[\e[38;5;251m\]@\[\e[38;5;208m\]\h"
  # Then current directory
  PS1+="$SEP📂 \[\e[38;5;252m\]\W"

  # If wide enough show Azure subscription 
  if (( $(tput cols) > 80 )); then
    PS1+="$(__azure_sub) "
    if [ -f "$HOME/.kube/config" ]; then
      PS1+="$(kube_ps1)"
    fi
  fi
  
  # Add git details
  PS1+="$(__git_branch) \[\e[0m\]\[\e[38;5;22m\]"
  
  # Status code
  if [ $e != 0 ]; then
     PS1+="\[\e[0m\]\[\e[38;5;197m\] ${e} 💩 "
  else
     PS1+="\[\e[0m\]\[\e[38;5;76m\]"
  fi
  PS1+="\n⮞ \[\e[0m\]"
}