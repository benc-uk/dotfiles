#!/bin/bash

# This file is sourced by both .bashrc and .zshrc as it contains common stuff

# Login banner thing 
if [ -f $HOME/dotfiles/banner.sh ]; then source $HOME/dotfiles/banner.sh; fi

# Handle SSH agent if /usr/bin/ssh-agent is available
# And not in a codespace
if [ -f /usr/bin/ssh-agent ] && [ -z "$CODESPACES" ]; then
    SSH_AGENT_ENV="$HOME/.ssh/agent-environment"
    function start_agent {
        echo "Initialising new SSH agent..."
        /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "$SSH_AGENT_ENV"
        chmod 600 "$SSH_AGENT_ENV"
        . "$SSH_AGENT_ENV" >/dev/null
        /usr/bin/ssh-add;
    }

    # Source SSH settings, if applicable
    if [ -f "$SSH_AGENT_ENV" ]; then
        . "$SSH_AGENT_ENV" >/dev/null
        ps -ef | grep $SSH_AGENT_PID | grep ssh-agent$ >/dev/null || {
            start_agent
        }
    else
        start_agent
    fi
fi

# Directory listing colors
export LS_COLORS="ow=35:ln=36:di=32"

# Extra aliases & env vars
if [ -f $HOME/dotfiles/aliases.sh ]; then source $HOME/dotfiles/aliases.sh; fi

# Auto complete 
if command -v az > /dev/null; then source /etc/bash_completion.d/azure-cli; fi

# Local overrides, secrets and post steps 
if [ -f $HOME/.local.rc ]; then source $HOME/.local.rc; fi
