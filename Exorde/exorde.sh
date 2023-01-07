#!/bin/bash

echo  "

████████╗██╗   ██╗██████╗ ██╗ █████╗ ███╗   ██╗ ██████╗ █████╗  
╚══██╔══╝██║   ██║██╔══██╗██║██╔══██╗████╗  ██║██╔════╝██╔══██╗
   ██║   ██║   ██║██████╔╝██║███████║██╔██╗ ██║██║     ███████║
   ██║   ██║   ██║██╔══██╗██║██╔══██║██║╚██╗██║██║     ██╔══██║
   ██║   ╚██████╔╝██████╔╝██║██║  ██║██║ ╚████║╚██████╗██║  ██║
   ╚═╝    ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝
 "
sleep 3

if [ ! $ADRESS ]; then
	read -p "Paste Your Metamask Adress: " ADRESS
	echo 'export METAMASKWALLET='$ADRESS >> $HOME/.bash_profile
fi


source $HOME/.bash_profile
                                                                                    
                                                                                        


# Install packages download git
apt update
apt install git
apt install apt-transport-https ca-certificates software-properties-common curl


# Install the dock, start it and check it

curl -f -s -S -L https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

screen -S exorde


docker run -d --restart unless-stopped --pull always --name exorde-cli exordelabs/exorde-cli -m $ADRESS -l 2
