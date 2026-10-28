#!/bin/bash
# cyberR1ck - simple multi-tool for Linux

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

banner() {
    clear
    echo -e "${GREEN}"
    cat << 'EOF'
  ____      _               ____  _      _
 / ___|   _| |__   ___ _ __|  _ \/ | ___| | __
| |  | | | | '_ \ / _ \ '__| |_) | |/ __| |/ /
| |__| |_| | |_) |  __/ |  |  _ <| | (__|   <
 \____\__, |_.__/ \___|_|  |_| \_\_|\___|_|\_\
      |___/
EOF
    echo -e "${NC}"
}

pause() {
    echo
    read -rp "Press Enter to go back to the menu..."
}

system_info() {
    echo "User:     $USER"
    echo "Host:     $(hostname)"
    echo "OS:       $(lsb_release -ds 2>/dev/null || uname -o)"
    echo "Kernel:   $(uname -r)"
    echo "Uptime:   $(uptime -p)"
}

disk_usage() {
    df -h --total | grep -E 'Filesystem|/$|total'
}

memory_usage() {
    free -h
}

local_ip() {
    hostname -I
}

public_ip() {
    curl -s --max-time 5 ifconfig.me || echo "No internet connection."
    echo
}

ping_test() {
    read -rp "Host to ping (default: google.com): " host
    host=${host:-google.com}
    ping -c 4 "$host"
}

find_file() {
    read -rp "File name to search in your home folder: " name
    [ -z "$name" ] && { echo "Nothing entered."; return; }
    find "$HOME" -iname "*$name*" 2>/dev/null | head -n 20
}

top_processes() {
    ps aux --sort=-%mem | head -n 6
}

while true; do
    banner
    echo "  1) System info"
    echo "  2) Disk usage"
    echo "  3) Memory usage"
    echo "  4) Local IP address"
    echo "  5) Public IP address"
    echo "  6) Ping a host"
    echo "  7) Find a file"
    echo "  8) Top 5 processes (by memory)"
    echo "  0) Exit"
    echo
    read -rp "Choose an option: " choice
    echo

    case $choice in
        1) system_info ;;
        2) disk_usage ;;
        3) memory_usage ;;
        4) local_ip ;;
        5) public_ip ;;
        6) ping_test ;;
        7) find_file ;;
        8) top_processes ;;
        0) echo "Bye!"; exit 0 ;;
        *) echo -e "${RED}Invalid option.${NC}" ;;
    esac
    pause
done