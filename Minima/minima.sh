#!/bin/bash

GREEN="\e[32m"
LIGHT_GREEN="\e[92m"
YELLOW="\e[33m"
DEFAULT="\e[39m"

function install_node {

echo -e "\e[1m\e[32m	What is your incentivecash uid:\e[0m"
   read incentivecash_uid
   echo export incentivecash_uid=${incentivecash_uid} >> $HOME/.bash_profile
   source ~/.bash_profile

echo -e "\e[1m\e[32m	Create your Password:\e[0m"
   read minima_mdspassword
   echo export minima_mdspassword=${minima_mdspassword} >> $HOME/.bash_profile
   source ~/.bash_profile

    echo "Installing Depencies..."
    sudo apt update 
    sudo apt upgrade -y
sudo adduser minima
sudo usermod -aG sudo minima
sudo curl -fsSL https://get.docker.com/ -o get-docker.sh
sudo chmod +x ./get-docker.sh && ./get-docker.sh
sudo usermod -aG docker $USER
docker run -d -e minima_mdspassword=$minima_mdspassword -e minima_server=true -v ~/minimadocker9001:/home/minima/data -p 9001-9004:9001-9004 --restart unless-stopped --name minima9001 minimaglobal/minima:latest
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
docker run -d --restart unless-stopped --name watchtower -e WATCHTOWER_CLEANUP=true -e WATCHTOWER_TIMEOUT=60s -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower
docker exec -it minima9001 minima
sleep 3
incentivecash uid:$incentivecash_uid


}

function mnemonic {
echo "Back-up Mnemonics"
    echo "DANGER!!!Ensure you write down the mnemonic as you can not recover the wallet without it."

sleep 2

docker exec -it minima9001 minima
sleep 3
vault

}


function status {
    echo "Checking node status.."
    sleep 2
    docker exec -it minima9001 minima
sleep 3
status

}


function remove_minima {
    echo "Removing Minima.."
    sleep 2

sudo wget -O minima_remove.sh https://raw.githubusercontent.com/minima-global/Minima/master/scripts/minima_remove.sh && sudo chmod +x minima_remove.sh && sudo ./minima_remove.sh -p 9001 -x
sudo rm -r /home/minima/
sudo userdel minima

}




function select_option {
    
    ESC=$( printf "\033")
    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "   $1 "; }
    print_selected()   { printf "  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n3 key 2>/dev/null >&2
                         if [[ $key = $ESC[A ]]; then echo up;    fi
                         if [[ $key = $ESC[B ]]; then echo down;  fi
                         if [[ $key = ""     ]]; then echo enter; fi; }

    for opt; do printf "\n"; done

    # determine current screen position for overwriting the options
    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - $#))

    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local selected=0
    while true; do
        local idx=0
        for opt; do
            cursor_to $(($startrow + $idx))
            if [ $idx -eq $selected ]; then
                print_selected "$opt"
            else
                print_option "$opt"
            fi
            ((idx++))
        done

        case `key_input` in
            enter) break;;
            up)    ((selected--));
                   if [ $selected -lt 0 ]; then selected=$(($# - 1)); fi;;
            down)  ((selected++));
                   if [ $selected -ge $# ]; then selected=0; fi;;
        esac
    done

    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    return $selected
}

function print_logo {
   echo  "

████████╗██╗   ██╗██████╗ ██╗ █████╗ ███╗   ██╗ ██████╗ █████╗  
╚══██╔══╝██║   ██║██╔══██╗██║██╔══██╗████╗  ██║██╔════╝██╔══██╗
   ██║   ██║   ██║██████╔╝██║███████║██╔██╗ ██║██║     ███████║
   ██║   ██║   ██║██╔══██╗██║██╔══██║██║╚██╗██║██║     ██╔══██║
   ██║   ╚██████╔╝██████╔╝██║██║  ██║██║ ╚████║╚██████╗██║  ██║
   ╚═╝    ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝
 "                                                                             
                                                                                        
}

function main {
    cd $HOME

    print_logo

    echo "Choose the command you want to use:"

    options=(
        "🛠 Install Minima Node"
        "👀 Check Status"
        "🔑 Back-up Mnemonic"
        "🗑 Delete Minima"
        "🚨 Exit"
    )

    select_option "${options[@]}"
    choice=$?
    clear

    case $choice in
        0)
            install_node
            ;;
        1)
            mnemonic
            ;;
        2)
            status
            ;;    
        3)
            remove_minima
            ;;
        4)
            exit 0
         
            ;;
    esac

    echo -e $DEFAULT
}

main
