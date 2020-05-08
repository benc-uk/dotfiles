# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load 
#ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="powerlevel10k/powerlevel10k"

POWERLEVEL9K_HOME_ICON=🏠
# POWERLEVEL9K_HOME_SUB_ICON=📁
# POWERLEVEL9K_FOLDER_ICON=🔨
# POWERLEVEL9K_BATTERY_ICON=🌡
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=🚦
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
# POWERLEVEL9K_SHORTEN_STRATEGY=truncate_folders
# POWERLEVEL9K_CONTEXT_TEMPLATE="%n"
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv battery time)
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=" "
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=" $ "

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
#plugins=(git)

source $ZSH/oh-my-zsh.sh

###################################
# My personal stuff from here...
###################################

# Fix fs.inotify.max_user_watches
sudo sysctl -p > /dev/null

# LS_COLORS
LS_COLORS="ow=35:ln=31:di=32"
export LS_COLORS

# Extra Alias ======================
source $HOME/.myaliases
FILE=$HOME/.secrets.sh ; [ -f $FILE ] && . $FILE

# Auto complete ====================
if command -v kubectl > /dev/null; then source <(kubectl completion zsh); fi
if command -v az > /dev/null; then source /etc/bash_completion.d/azure-cli; fi

# Cheesey login banner thing ==============
ip=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
echo -e "\e[96m╔═══════════════════════════════════════════════════════"
echo -e "\e[96m║ \e[38;5;82m$(lsb_release -ds) 🍺"
echo -e "\e[96m║ \e[38;5;45mOh My Zsh \e[38;5;255m& \e[38;5;201mPowerlevel10K 🚀"
if [ ! -z $WSL_INTEROP ]; then echo -e "\e[96m║ \e[38;5;214mWindows Subsystem For Linux v2 🐱‍🔥"; fi
echo -e "\e[96m╠═══════════════════════════════════════════════════════"
echo -e "\e[96m║ \e[1;37meth0 IP:\t\e[0;34m$ip"
echo -e "\e[96m║ \e[1;37mKernel:\t\e[0;33m$(uname -r)"
echo -e "\e[96m╚═══════════════════════════════════════════════════════"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
