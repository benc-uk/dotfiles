# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load 
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories  much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Ohmyzsh plugins
plugins=(
  git
  dotenv
  npm
  docker
  encode64
  helm
  z
  web-search
)

# Now enable oh-my-zsh
source $ZSH/oh-my-zsh.sh

##################################################
# My personal stuff from here...
##################################################

# LS_COLORS
LS_COLORS="ow=35:ln=31:di=32"
export LS_COLORS

# Extra aliases ======================
if [ -f $HOME/.aliases.rc ]; then source $HOME/.aliases.rc; fi

# Auto complete ====================
if command -v kubectl > /dev/null; then source <(kubectl completion zsh); fi
if command -v az > /dev/null; then source /etc/bash_completion.d/azure-cli; fi

# Login banner thing ==============
if [ -f $HOME/.banner.rc ]; then source $HOME/.banner.rc; fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Local overrides, secrets and post steps ==============
if [ -f $HOME/.local.rc ]; then source $HOME/.local.rc; fi
