#!/bin/bash

WILL BE UPDATE.. DONT USE THIS SCRIPT
echo  "

████████╗██╗   ██╗██████╗ ██╗ █████╗ ███╗   ██╗ ██████╗ █████╗  
╚══██╔══╝██║   ██║██╔══██╗██║██╔══██╗████╗  ██║██╔════╝██╔══██╗
   ██║   ██║   ██║██████╔╝██║███████║██╔██╗ ██║██║     ███████║
   ██║   ██║   ██║██╔══██╗██║██╔══██║██║╚██╗██║██║     ██╔══██║
   ██║   ╚██████╔╝██████╔╝██║██║  ██║██║ ╚████║╚██████╗██║  ██║
   ╚═╝    ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝
 "


                                                                                    
                                                                                        
sleep 3

# set vars
if [ ! $NODENAME ]; then
read -p "Enter node name: " NODENAME
echo 'export NODENAME='$NODENAME >> $HOME/.bash_profile
fi


sudo apt update 
sudo apt install -y unzip logrotate git jq sed wget curl coreutils systemd
temp_folder=$(mktemp -d) && cd $temp_folder

# Configurations
go_package_url="https://go.dev/dl/go1.18.linux-amd64.tar.gz"
go_package_file_name=${go_package_url##*\/}
wget -q $go_package_url
sudo tar -C /usr/local -xzf $go_package_file_name
echo "export PATH=\$PATH:/usr/local/go/bin" >>~/.profile
echo "export PATH=\$PATH:\$(go env GOPATH)/bin" >>~/.profile
source ~/.profile
cd

### Download Lava
git clone https://github.com/K433QLtr6RA9ExEq/GHFkqmTzpdNLDd6T.git
cd GHFkqmTzpdNLDd6T/testnet-1
source setup_config/setup_config.sh
echo "Lava config file path: $lava_config_folder"
mkdir -p $lavad_home_folder
mkdir -p $lava_config_folder
cp default_lavad_config_files/* $lava_config_folder
cp genesis_json/genesis.json $lava_config_folder/genesis.json

### Download Lava
go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v1.0.0
mkdir -p $lavad_home_folder/cosmovisor
wget https://lava-binary-upgrades.s3.amazonaws.com/testnet/cosmovisor-upgrades/cosmovisor-upgrades.zip
unzip cosmovisor-upgrades.zip
cp -r cosmovisor-upgrades/* $lavad_home_folder/cosmovisor

# Set the environment variables
echo "# Setup Cosmovisor" >> ~/.profile
echo "export DAEMON_NAME=lavad" >> ~/.profile
echo "export CHAIN_ID=lava-testnet-1" >> ~/.profile
echo "export DAEMON_HOME=$HOME/.lava" >> ~/.profile
echo "export DAEMON_ALLOW_DOWNLOAD_BINARIES=true" >> ~/.profile
echo "export DAEMON_LOG_BUFFER_SIZE=512" >> ~/.profile
echo "export DAEMON_RESTART_AFTER_UPGRADE=true" >> ~/.profile
echo "export UNSAFE_SKIP_BACKUP=true" >> ~/.profile
source ~/.profile


# Initialize the chain
$lavad_home_folder/cosmovisor/genesis/bin/lavad init \
$NODENAME \
--chain-id lava-testnet-1 \
--home $lavad_home_folder \
--overwrite
cp genesis_json/genesis.json $lava_config_folder/genesis.json


# Create Cosmovisor unit file
echo "[Unit]
Description=Cosmovisor daemon
After=network-online.target
[Service]
Environment="DAEMON_NAME=lavad"
Environment="DAEMON_HOME=${HOME}/.lava"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=true"
Environment="DAEMON_LOG_BUFFER_SIZE=512"
Environment="UNSAFE_SKIP_BACKUP=true"
User=$USER
ExecStart=${HOME}/go/bin/cosmovisor start --home=$lavad_home_folder --p2p.seeds $seed_node
Restart=always
RestartSec=3
LimitNOFILE=infinity
LimitNPROC=infinity
[Install]
WantedBy=multi-user.target
" >cosmovisor.service
sudo mv cosmovisor.service /lib/systemd/system/cosmovisor.service



# Enable the cosmovisor service so that it will start automatically when the system boots

sudo systemctl daemon-reload
sudo systemctl enable cosmovisor.service
sudo systemctl restart systemd-journald
sudo systemctl start cosmovisor   


# Prepare an account
current_lavad_binary="$HOME/.lava/cosmovisor/current/bin/lavad"
ACCOUNT_NAME=wallet
$current_lavad_binary keys add $ACCOUNT_NAME