#!/bin/bash

GREEN="\e[32m"
LIGHT_GREEN="\e[92m"
YELLOW="\e[33m"
DEFAULT="\e[39m"


    echo "Installing Depencies..."
    sudo apt update 
    sudo apt upgrade -y
sudo adduser minima
sudo usermod -aG sudo minima
sudo curl -fsSL https://get.docker.com/ -o get-docker.sh
sudo chmod +x ./get-docker.sh && ./get-docker.sh
sudo usermod -aG docker $USER



function remove_minima {
    echo "Removing Minima.."
    sleep 2

docker stop minima9001
docker rm minima9001
sudo wget -O minima_remove.sh https://raw.githubusercontent.com/minima-global/Minima/master/scripts/minima_remove.sh && sudo chmod +x minima_remove.sh && sudo ./minima_remove.sh -p 9001 -x
sudo rm -r /home/minima/
sudo userdel minima

}

function restart_node {
    echo "Restarting Minima.."
    sleep 2

docker restart minima9001

}


function check_logs {
    echo "Cheking Logs.."
    sleep 2

docker logs --follow minima9001

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
        "🔍 Check Logs"
        "♻️ Restart"
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
            check_logs
            ;;
        2)
            restart_node
            ;;    
        3)
            remove_minima
            ;;  
        6)
            exit 0
         
            ;;
    esac

    echo -e $DEFAULT
}

main
