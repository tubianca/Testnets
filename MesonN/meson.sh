#!/bin/bash

sleep 1 

echo -e "\033[0;35m"
echo "  _____ _   _ ____ ___    _    _   _  ____    _    
echo " |_   _| | | | __ )_ _|  / \  | \ | |/ ___|  / \   
echo "   | | | | | |  _ \| |  / _ \ |  \| | |     / _ \  
echo "   | | | |_| | |_) | | / ___ \| |\  | |___ / ___ \ 
echo "   |_|  \___/|____/___/_/   \_\_| \_|\____/_/   \_\
echo -e "\e[0m"


sleep 3

avail_space=`df $PWD -h | awk '/[0-9]%/{print $(NF-2)}' | sed 's/.$//'`
if [ $avail_space -lt 20 ]; then
	echo -e '\e[31mYou have less than 20GB available space, please free some space and retry install.\e[39m'
	exit 1
fi

function setupVars {
	if [ ! $MESON_TOKEN ]; then
		read -p "Enter your meson token: " MESON_TOKEN
		echo 'export MESON_TOKEN='${MESON_TOKEN} >> $HOME/.bash_profile
	fi
	echo -e '\n\e[42mYour meson token:' $MESON_TOKEN '\e[0m\n'
	if [ ! $MESON_PORT ]; then
		read -p "Enter your meson port (19091 by default): " MESON_PORT
		MESON_PORT=${MESON_PORT:-19091}
		echo 'export MESON_PORT='${MESON_PORT} >> $HOME/.bash_profile
	fi
	echo -e '\n\e[42mYour meson port:' $MESON_PORT '\e[0m\n'
	if [ ! $MESON_SPACELIMIT ]; then
		echo -e '\e[42mAt this moment you have' $avail_space 'GB available space\e[0m'
		read -p "Enter your spacelimit for Meson (at least 20GB), ONLY NUMBER (without GB): " MESON_SPACELIMIT
		MESON_SPACELIMIT=${MESON_SPACELIMIT:-20}
		echo 'export MESON_SPACELIMIT='${MESON_SPACELIMIT} >> $HOME/.bash_profile
	fi
	echo -e '\n\e[42mYour Meson spacelimit:' $MESON_SPACELIMIT '\e[0m\n'
	. $HOME/.bash_profile
	sleep 1
}

function setupSwap {
	echo -e '\n\e[42mSet up swapfile\e[0m\n'
	curl -s https://raw.githubusercontent.com/tubianca/Testnets/main/MesonN/swap4.sh | bash
}

function installDeps {
	echo -e '\n\e[42mPreparing to install\e[0m\n' && sleep 1
	cd $HOME
	sudo apt update
	sudo apt install make clang pkg-config libssl-dev build-essential git jq ufw -y < "/dev/null"
}

function installSoftware {
	echo -e '\n\e[42mInstall software\e[0m\n' && sleep 1
	ufw allow 80
	ufw allow 443
	ufw allow 19091
	wget -O meson.tar.gz https://staticassets.meson.network/public/meson_cdn/v3.1.18/meson_cdn-linux-amd64.tar.gz 
	tar -zxf meson.tar.gz
	cd ./meson_cdn-linux-amd64
#token = $MESON_TOKEN
#port = $MESON_PORT
	sudo ./meson_cdn config set --token=$MESON_TOKEN --https_port=$MESON_PORT --cache.size=30
	sudo $HOME/meson_cdn-linux-amd64/service install meson_cdn
	sudo systemctl daemon-reload
	sudo systemctl enable meson_cdn 
	sudo systemctl restart meson_cdn 
	echo -e '\n\e[42mCheck node status\e[0m\n' && sleep 3
	if [[ `sudo systemctl status meson_cdn | grep "active"` =~ "running" ]]; then
	  echo -e "Your Meson minrt \e[32minstalled and works\e[39m!"
	  echo -e "You can check miner status by the command \e[7msudo systemctl status meson_cdn\e[0m"
	  echo -e "Press \e[7mQ\e[0m for exit from status menu"
	else
	  echo -e "Your Meson miner \e[31mwas not installed correctly\e[39m, please reinstall."
	fi
}

function deleteMESON {
	sudo systemctl disable meson_cdn
	sudo systemctl stop meson_cdn
}

PS3='Please enter your choice (input your option number and press enter): '
options=("Install" "Delete" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Install")
            echo -e '\n\e[42mYou choose install...\e[0m\n' && sleep 1
			setupVars
			setupSwap
			installDeps
			installSoftware
			break
            ;;
		"Delete")
            echo -e '\n\e[31mYou choose delete...\e[0m\n' && sleep 1
			deleteMESON
			echo -e '\n\e[42mMeson miner was deleted!\e[0m\n' && sleep 1
			break
            ;;
        "Quit")
            break
            ;;
        *) echo -e "\e[91minvalid option $REPLY\e[0m";;
    esac
done
