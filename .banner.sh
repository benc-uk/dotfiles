ip=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
where="Some Linux system 🤷"
if [ ! -z $WSL_INTEROP ]; then where="Windows Subsystem for Linux v2 💜"; fi
if [ ! -z $ACC_TERM_ID ]; then where="Azure Cloud Shell ($ACC_LOCATION)\e[37m☁"; fi

echo -e "\e[38;5;35m╔═════ \e[38;5;214m🚀  Oh My Zsh \e[37m& \e[38;5;214mPowerlevel10K"
echo -e "\e[38;5;35m╠══ \e[38;5;163mVersion: \e[38;5;75m$(lsb_release -ds) 😸"
echo -e "\e[38;5;35m╠══ \e[38;5;163mIP:      \e[38;5;75m$ip 📡"
echo -e "\e[38;5;35m╠══ \e[38;5;163mKernel:  \e[38;5;75m$(uname -r) 🚦"
echo -e "\e[38;5;35m╚══ \e[38;5;163mEnviron: \e[38;5;75m$where"
