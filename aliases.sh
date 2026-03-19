# Kubernetes
alias k='kubectl'
#alias kn='kubectl config set-context --current --namespace '
alias kn='kubens'
alias kc='kubectx'
#alias helm-clean='helm ls --short | xargs -L1 helm delete'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgn='kubectl get nodes'
alias kga='kubectl get pods,svc,ing'
alias klog='kubectl logs -f'
alias kd='kubectl describe'

# Misc
alias tf='terraform'
alias pubkey='cat ~/.ssh/id_rsa.pub'
alias gmt='go mod tidy'
alias winexplore='/mnt/c/Windows/SysWOW64/explorer.exe .'
alias co='copilot'
alias ask='copilot --yolo -p '
# This undoes some crap that ohmyzsh does to grep
alias grep='grep --color=auto'

# Python
alias venv-act='if [ -d .venv ]; then source .venv/bin/activate; elif [ -d venv ]; then source venv/bin/activate; else echo "No virtualenv found!"; fi'
alias venv-new='(python3 -m venv .venv || python3 -m venv .venv) && source .venv/bin/activate'
alias venv-del='deactivate && rm -rf .venv'

# Linux stuff
alias pub-ip='echo -e "$(curl -sSL ifconfig.me)"'

# Old WSL2 workarounds, commented out now the clock sync is fixed
#alias timesync='sudo hwclock -s'
#alias dnsfix='echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf'
#alias ntpsync='sudo ntpdate time.windows.com'

# Docker & Containers
#alias docker-start='sudo /etc/init.d/docker start'
#alias docker-stop='sudo /etc/init.d/docker stop'
alias container-prune='docker container prune -f && docker image prune -f && docker volume prune -f && docker buildx prune -f'
alias container-wipe='docker system prune -a --volumes -f'
#alias docker-clean='docker rm -f $(docker ps -a -q)'

# Git & GitHub
alias g='git'
alias gh-open='gh repo view --web'

# Azure CLI
alias az-nuke='az group delete --no-wait --yes -g'

# Node
alias npm-clean='rm -rf node_modules && rm -rf package-lock.json && npm install'

# Extra functions, needs fzf installed
# fkill: interactively kill processes
fkill() {
    if ! command -v fzf > /dev/null 2>&1; then
        echo "fzf is not installed. Please install fzf to use this function."
        return 1
    fi
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}

# fbr: interactively checkout git branches
fbr() {
  if ! command -v fzf > /dev/null 2>&1; then
      echo "fzf is not installed. Please install fzf to use this function."
      return 1
  fi
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
