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
  #git
  #npm
  #docker
  encode64
  #helm
  z
  web-search
  zsh-autosuggestions
)

# Now enable oh-my-zsh
source $ZSH/oh-my-zsh.sh

##################################################
# My personal stuff from here...
##################################################

source "$HOME"/dotfiles/common.sh

# Auto complete
if command -v kubectl > /dev/null; then source <(kubectl completion zsh); fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ==============================================================================================
# If you see anything after this line it's been auto-added, and probably should be removed/moved
# ==============================================================================================
