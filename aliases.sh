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
# This undoes some crap that ohmyzsh does to grep
alias grep='grep --color=auto'

# Python
alias venv-act='if [ -d .venv ]; then source .venv/bin/activate; elif [ -d venv ]; then source venv/bin/activate; else echo "No virtualenv found!"; fi'
alias venv-new='(python3.10 -m venv .venv || python3 -m venv .venv) && source .venv/bin/activate'
alias venv-del='deactivate && rm -rf .venv'

# Linux stuff
alias pub-ip='echo -e "$(curl -sSL ifconfig.me)"'

# Old WSL2 workarounds, commented out now the clock sync is fixed
#alias timesync='sudo hwclock -s'
#alias dnsfix='echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf'
#alias ntpsync='sudo ntpdate time.windows.com'

# Docker
#alias docker-start='sudo /etc/init.d/docker start'
#alias docker-stop='sudo /etc/init.d/docker stop'
alias docker-prune='docker container prune -f && docker image prune -f && docker volume prune -f && docker buildx prune -f'
alias docker-wipe='docker buildx prune -a && docker image prune -a'
alias docker-clean='docker rm -f $(docker ps -a -q)'

# Git & GitHub
alias g='git'
alias gh-open='gh repo view --web'

# Azure CLI
alias az-nuke='az group delete --no-wait --yes -g'

# Node
alias npm-clean='rm -rf node_modules && rm -rf package-lock.json && npm install'

