#!/bin/bash
cat << EOF
 _______ _    _ ____ _____          _   _  _____          
|__   __| |  | |  _ \_   _|   /\   | \ | |/ ____|   /\    
   | |  | |  | | |_) || |    /  \  |  \| | |       /  \   
   | |  | |  | |  _ < | |   / /\ \ | . ` | |      / /\ \  
   | |  | |__| | |_) || |_ / ____ \| |\  | |____ / ____ \ 
   |_|   \____/|____/_____/_/    \_\_| \_|\_____/_/    \_\
                                                          
                                                          

EOF

sleep 5

bold=$(tput bold)
underline=$(tput smul)
italic=$(tput sitm)
info=$(tput setaf 2)
error=$(tput setaf 160)
warn=$(tput setaf 214)
reset=$(tput sgr0)

clear;
echo "Tubi - Massa Node Installation"
sleep 3

# server update and port settings
sudo apt-get update -y
sudo apt install ufw -y
sudo ufw allow 22
sudo ufw allow ssh
sudo ufw allow 31244/tcp
sudo ufw allow 31245/tcp
sudo ufw enable


clear;
sudo ufw status
echo "${info}INFO${reset}: installation is ${bold}set${reset} please wait... "

sleep 5

# required libraries
sudo apt install pkg-config curl git build-essential libssl-dev libclang-dev -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustc --version
rustup toolchain install nightly
rustup default nightly
rustc --version
git clone --branch testnet https://github.com/massalabs/massa.git

# rustc explain fixed
sudo apt install make clang pkg-config libssl-dev -y
rustup install nightly-2022-11-14
rustup default nightly-2022-11-14

# settings file
clear;
echo "---------------------"
echo "${info}INFO${reset}: Libraries loaded ${bold}successfully${reset}..."
echo "---------------------"
sleep 2

read -p 'Set ip address: ' ipadr
read -p 'Set node password: ' walletpassword

echo -e "[network]\nroutable_ip = '$ipadr'" >> massa/massa-node/config/config.toml

sudo apt install screen -y

# node start
screen -S massa-node -d -m bash
screen -r massa-node -X stuff "cd massa/massa-node/ && RUST_BACKTRACE=full cargo run --release -- -p $walletpassword |& tee logs.txt"$(echo -ne '\015')
echo "${info}INFO${reset}: NODE ${bold}STARTED${reset}."

# client start
screen -S massa-client -d -m bash
screen -r massa-client -X stuff "cd massa/massa-client/ && cargo run --release -- -p $walletpassword"$(echo -ne '\015')
echo "${info}INFO${reset}: CLIENT ${bold}STARTED${reset}."

cat << EOF
                      .*%%#,
              %%%%%%%%%%%%%%%%%%%%%#*             
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#         
       .%%%%%%%#    %%%%%%%%%%%    %%%%%%%%       
     %%%%%%%%%%%%     %#%%%%%     %%%%%%%%%%%(    
    %%%%%%%%%%%%%%     %%%%%     %%%%%%%%%%%%%#   
  *%%%%%%%%%%%%%%%%#    ,#     %%%%%%%#%%%%%%%%%  
 .%%%%%%%%%              #              %%%%%%%%# 
 %%%%%%%%%%     %%%%%%%%%%%%%%%%%##     %%%%%%%%%#
.%%%%%%%%%%%#    .%%%%%%%%%%%%%%%     #%%%%%%%%%%#
%%%%%%%#####%#     %%%%%%%%%%%%%     ########%%%%%
.%%%%#             %%%%%%%%%%%#%             %%%#%
 %%%%%%%%%%%%%%%%%    %%%%%%#    #%%%%%%%%%%%%%%%%
 .%%%%%%%%%%%%%%       #%%##       %%%%%%%%%%%%%% 
  .#%%%%%%%%%##          #          %%%%%%%%%%%#  
    %%%%%%%%%     %%%        .%##    *%%%%%%%%%   
     #%%%%%%#    %%%%%#     %%%%##    %%%%%%#     
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
          /#%%%%%%%%%%%%%%%%%%%%%%%%%%#%          
              .%%%%%%%%%%%%%%%%%%%%#

EOF
echo "${info}INFO${reset}: Screens have been created successfully, enter the ${bold}(screen -ls)${reset} command to view them."
echo "${warn}WARN${reset}: It may take 10-15 minutes to  ${bold}compile${reset}"
sleep 3