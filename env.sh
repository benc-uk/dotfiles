# Kubectl
export KUBE_EDITOR=nano

# Azure CLI
export AZURE_CORE_OUTPUT=yamlc

# Enable BuildKit for Docker
export DOCKER_BUILDKIT=1

# Prevent Python dumbness
export PIP_REQUIRE_VIRTUALENV=true

#
# Extra paths ============================================================
#
PATH="$HOME/.npm-global/bin:$HOME/bin:$HOME/.local/bin:$PATH"

# Golang
# Note. GOPATH is left as $HOME/go, add $GOPATH/bin & /usr/local/go/bin to path
PATH="$HOME/go/bin:/usr/local/go/bin:$PATH"

# Dotnet Core (global tools)
PATH="$HOME/.dotnet/tools:$PATH"

# Dapr (Only required after running `dapr init`)
PATH="$HOME/.dapr/bin:$PATH"

# Rust
PATH="$HOME/.cargo/bin:$PATH"
