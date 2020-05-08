ip=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
where="Some Linux system 🤷"
if [ ! -z $WSL_INTEROP ]; then where="Windows Subsystem for Linux v2 💜"; fi
if [ ! -z $ACC_TERM_ID ]; then where="Azure Cloud Shell ($ACC_LOCATION)\e[37m☁"; fi
if [ -f /.dockerenv ]; then where="Inside a Docker container 📦"; fi

echo -e "\e[38;5;192m╭───── \e[38;5;202m🚀  Oh My Zsh \e[37m& \e[38;5;226mPowerlevel10K"
echo -e "\e[38;5;155m├──❱ \e[38;5;129mVersion: \e[38;5;45m$(lsb_release -ds) 😸"
echo -e "\e[38;5;118m├──❱ \e[38;5;129mIP:      \e[38;5;45m$ip 📡"
echo -e "\e[38;5;40m├──❱ \e[38;5;129mKernel:  \e[38;5;45m$(uname -r) 🚦"
echo -e "\e[38;5;34m├──❱ \e[38;5;129mHost:    \e[38;5;45m$(hostname) 🏠"
echo -e "\e[38;5;28m└──❱ \e[38;5;129mEnviron: \e[38;5;45m$where"
echo -e ""
#echo -e "\e[38;5;56m██\e[38;5;27m██\e[38;5;33m██\e[38;5;38m██\e[38;5;45m██\e[38;5;87m██\e[38;5;50m██\e[38;5;48m██\e[38;5;118m██\e[38;5;156m██\e[38;5;190m██\e[38;5;226\e[38;5;220m██\e[38;5;214m██\e[38;5;208m██"
