#!/bin/bash

# This script is a fancy banner that shows a bunch of information about the environment
# it is running in. It is designed to be sourced from your .bashrc or .zshrc file.

# Function to lookup the environment we are running in
environLookup() {
  if [[ -n $WSL_INTEROP ]]; then echo "Windows Subsystem for Linux v2 💚" && return 0; fi
  if [[ -n $WSL_DISTRO_NAME ]]; then echo "Windows Subsystem for Linux v1 💙" && return 0; fi
  if [[ -f /.dockerenv ]]; then echo "Inside a Docker container 📦" && return 0; fi
  if [[ -n $REMOTE_CONTAINERS_IPC ]]; then echo "Inside a Devcontainer. Let's code! 💻" && return 0; fi
  if [[ -n $ACC_TERM_ID ]]; then echo -e "Azure Cloud Shell ($ACC_LOCATION)\e[37m💭" && return 0; fi
  if [[ $CODESPACES == "true" ]]; then echo -e "GitHub Codespaces\e[37m🐙" && return 0; fi
  if command -v lsb_release &> /dev/null; then
    if [[ "$(lsb_release -i)" =~ "Raspbian" ]]; then echo "Raspberry Pi 🍇" && return 0; fi
  fi
  if [[ -n "$MINGW_PREFIX" ]]; then echo "MSYS/Cygwin on Windows 🐧" && return 0; fi

  echo "Some Linux system 🤷"
}

# Loop though the following eth0, wifi0, docker0, tap0 until we find a valid IP address
declare -a interfaces=("eth0" "wifi0" "docker0" "tap0")
declare ip="?.?.?.?"
if which ip > /dev/null; then
  for i in "${interfaces[@]}"; do
    ip=$(ip addr show "$i" 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1)
    if [[ -n $ip ]]; then break; fi
  done
fi

# Get public IP address and cache results
declare publicip_cache_age=99900
if [[ -f /tmp/publicip ]]; then
  publicip_cache_age=$(( $(date +'%s') - $(stat -c %Y /tmp/publicip) ))
fi
# Cache results for 6 hours, as your IP doesn't change that often!
if (( publicip_cache_age > (6*3600) )); then
  curl -m 1 -s -4 ifconfig.me > /tmp/publicip
fi
publicip=$(cat /tmp/publicip)

# Work out where we are running
where=$(environLookup)

# And what shell is in use (default assume Zsh + P10K)
shelltype="🚀 Oh My Zsh \e[37m& \e[38;5;226mPowerlevel10K"
if [[ $0 =~ "bash" ]]; then shelltype="👍 Standard \e[38;5;226mBash \e[38;5;202mShell"; fi

# lsb_release might not be installed :/
version="Unknown!"
if test -f /etc/os-release; then
  version=$(cat /etc/os-release | grep VERSION= | cut -d'"' -f2)
elif command -v lsb_release &> /dev/null; then
  version=$(lsb_release -ds)
fi

# Get the uptime
uptime="Unknown!"
if command -v uptime &> /dev/null; then
  uptime=$(uptime -p)
fi

# Show the banner
echo -e "\e[38;5;192m╭─────── \e[38;5;202m$shelltype"
echo -e "\e[38;5;155m├──❱ \e[38;5;135m📻 Environ:  \e[38;5;45m$where"
echo -e "\e[38;5;118m├──❱ \e[38;5;135m🥜 Kernel:  \e[38;5;45m $(uname -r)"
echo -e "\e[38;5;040m├──❱ \e[38;5;135m🥇 OS:      \e[38;5;45m $version"
echo -e "\e[38;5;034m├──❱ \e[38;5;135m📡 IP:      \e[38;5;45m $ip / $publicip"
echo -e "\e[38;5;028m├──❱ \e[38;5;135m🏠 Host:    \e[38;5;45m $(hostname)"
echo -e "\e[38;5;028m╰──❱ \e[38;5;135m🚦 Uptime:  \e[38;5;45m $uptime"
echo -e ""
