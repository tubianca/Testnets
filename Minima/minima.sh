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

    echo "Installing Depencies..."
    sudo apt update 
    sudo apt upgrade -y
sudo adduser minima
sudo usermod -aG sudo minima
sudo curl -fsSL https://get.docker.com/ -o get-docker.sh
sudo chmod +x ./get-docker.sh && ./get-docker.sh
sudo usermod -aG docker $USER



