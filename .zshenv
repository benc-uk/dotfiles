# Azure CLI
export AZURE_CORE_OUTPUT=jsonc

# Running Docker locally
#export DOCKER_HOST=tcp://0.0.0.0:2375

# Golang stuff, removed in Go 1.13
#export GO111MODULE=on

# Java 
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Duffle/CNAB 
export CLEANUP_CONTAINERS="true"

#
# Extra paths ============================================================
#
PATH="$HOME/.npm-global/bin:$HOME/bin:$HOME/.local/bin:$PATH"

# Golang 
# GOPATH is left as default $HOME/go 
# Add GOPATH/bin and /usr/local/go/bin to system path
PATH="$HOME/go/bin:/usr/local/go/bin:$PATH" 

# Ruby (For Jekyll) 
export GEM_HOME="$HOME/gems"
PATH="$HOME/gems/bin:$PATH"

# Dotnet Core (global tools) 
PATH="$HOME/.dotnet/tools:$PATH"

# Porter 
PATH="$PATH:$HOME/.porter"

# Rust 
PATH="$PATH:$HOME/.cargo/bin"

# Func Core Tools (as they never update the deb package 
PATH="$HOME/.local/func-core-tools:$PATH"