#!/bin/bash
# ===========================================================
# Multi-Panel Interactive Script
# Keandr Coding Hub
# ===========================================================

# --- COLORS ---
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
ORANGE='\033[1;38;5;214m'
WHITE='\033[1;37m'
NC='\033[0m'

# --- STYLES ---
BOLD='\033[1m'
DIM='\033[2m'
UNDERLINE='\033[4m'
BLINK='\033[5m'

pause() { 
    echo -e "${CYAN}"
    read -p "> Press Enter to continue..." fackEnterKey
    echo -e "${NC}"
}

banner() {
    clear
    echo -e "${BLUE}"
    echo -e "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo -e "║                                                                              ║"
    echo -e "\033[96m"
    echo "  ██████  ██████  ██████  ██ ███    ██  ██████      ██   ██ ██    ██ ██████  "
    echo " ██      ██    ██ ██   ██ ██ ████   ██ ██           ██   ██ ██    ██ ██   ██ "
    echo " ██      ██    ██ ██   ██ ██ ██ ██  ██ ██   ███     ███████ ██    ██ ██████  "
    echo " ██      ██    ██ ██   ██ ██ ██  ██ ██ ██    ██     ██   ██ ██    ██ ██   ██ "
    echo "  ██████  ██████  ██████  ██ ██   ████  ██████      ██   ██  ██████  ██████  "
    echo "                                                                             "
    echo -e "${BLUE}"
    echo -e "║                                                                              ║"
    echo -e "╠══════════════════════════════════════════════════════════════════════════════╣"
    echo -e "║                     [>] Multi-Panel Control Center v2.0                     ║"
    echo -e "╚══════════════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo -e "${DIM}                             Keandr Coding Hub${NC}"
    echo
}

# --- ANIMATION FUNCTIONS ---
show_loading() {
    local pid=$1
    local text=$2
    local delay=0.1
    local spinstr='|/-\'
    
    echo -ne "${CYAN}${text}... ${NC}"
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
    echo -e "${GREEN}[+] Done!${NC}"
}

# --- PANEL MENU ---
panel_menu() {
    while true; do
        banner
        echo -e "${BLUE}┌────────────────────────────────────────────────────────────────────────────┐${NC}"
        echo -e "${BLUE}│                        ${WHITE}[#] ${BOLD}PANEL MANAGEMENT${NC}${BLUE}                         │${NC}"
        echo -e "${BLUE}├────────────────────────────────────────────────────────────────────────────┤${NC}"
        echo -e "${BLUE}│${NC}                                                                        ${BLUE}│${NC}"
        echo -e "${BLUE}│${NC}  ${GREEN}1)${NC} [*] 1 Panel                   ${GREEN}6)${NC} [@] Dashboard v4          ${BLUE}│${NC}"
        echo -e "${BLUE}│${NC}  ${GREEN}2)${NC} [W] Pterodactyl               ${GREEN}7)${NC} [$] Payment Gateway       ${BLUE}│${NC}"
        echo -e "${BLUE}│${NC}  ${GREEN}3)${NC} [~] JackTera v3               ${GREEN}8)${NC} [&] CtrlPanel             ${BLUE}│${NC}"
        echo -e "${BLUE}│${NC}  ${GREEN}4)${NC} [~] JackTera v4               ${GREEN}9)${NC} [@] CPanel                ${BLUE}│${NC}"
        echo -e "${BLUE}│${NC}  ${GREEN}5)${NC} [@] Dashboard v3              ${GREEN}10)${NC} [<] Back to Main Menu    ${BLUE}│${NC}"
        echo -e "${BLUE}│${NC}                                                                        ${BLUE}│${NC}"
        echo -e "${BLUE}└────────────────────────────────────────────────────────────────────────────┘${NC}"
        echo
        echo -e "${DIM}Select an option [1-10]:${NC} "
        echo -ne "${CYAN}> ${NC}"
        read -p "" pchoice

        case $pchoice in
            1) execute_command "1 Panel" "1panel.sh" ;;
            2) execute_command "Pterodactyl" "pterodactyl.sh" ;;
            3) execute_command "JackTera v3" "jacktera_v3.sh" ;;
            4) execute_command "JackTera v4" "jacktera_v4.sh" ;;
            5) execute_command "Dashboard v3" "dashboard_v3.sh" ;;
            6) execute_command "Dashboard v4" "dashboard_v4.sh" ;;
            7) execute_command "Payment Gateway" "payment.sh" ;;
            8) execute_command "CtrlPanel" "ctrlpanel.sh" ;;
            9) execute_command "CPanel" "cpanel.sh" ;;
            10) break ;;
            *) echo -e "${RED}[!] Invalid choice! Please select between 1-10${NC}"; pause ;;
        esac
    done
}

# --- TOOLS MENU ---
tools_menu() {
    while true; do
        banner
        echo -e "${GREEN}┌────────────────────────────────────────────────────────────────────────────┐${NC}"
        echo -e "${GREEN}│                        ${WHITE}[#] ${BOLD}SYSTEM TOOLS${NC}${GREEN}                             │${NC}"
        echo -e "${GREEN}├────────────────────────────────────────────────────────────────────────────┤${NC}"
        echo -e "${GREEN}│${NC}                                                                        ${GREEN}│${NC}"
        echo -e "${GREEN}│${NC}  ${YELLOW}1)${NC} [#] Root Access                ${YELLOW}5)${NC} [@] IPv4 Configuration    ${GREEN}│${NC}"
        echo -e "${GREEN}│${NC}  ${YELLOW}2)${NC} [~] Tailscale VPN              ${YELLOW}6)${NC} [>] Port Forwarding       ${GREEN}│${NC}"
        echo -e "${GREEN}│${NC}  ${YELLOW}3)${NC} [*] Cloudflare DNS             ${YELLOW}7)${NC} [X] RDP Setup             ${GREEN}│${NC}"
        echo -e "${GREEN}│${NC}  ${YELLOW}4)${NC} [i] System Information         ${YELLOW}8)${NC} [<] Back to Main Menu     ${GREEN}│${NC}"
        echo -e "${GREEN}│${NC}                                                                        ${GREEN}│${NC}"
        echo -e "${GREEN}└────────────────────────────────────────────────────────────────────────────┘${NC}"
        echo
        echo -e "${DIM}Select an option [1-8]:${NC} "
        echo -ne "${CYAN}> ${NC}"
        read -p "" tchoice

        case $tchoice in
            1) execute_command "Root Access" "root.sh" ;;
            2) execute_command "Tailscale VPN" "tailscale.sh" ;;
            3) execute_command "Cloudflare DNS" "cloudflare.sh" ;;
            4) execute_command "System Information" "systeminfo.sh" ;;
            5) execute_command "IPv4 Configuration" "ipv4.sh" ;;
            6) execute_command "Port Forwarding" "portforward.sh" ;;
            7) execute_command "RDP Setup" "rdp.sh" ;;
            8) break ;;
            *) echo -e "${RED}[!] Invalid choice! Please select between 1-8${NC}"; pause ;;
        esac
    done
}

# --- THEME MENU ---
theme_menu() {
    while true; do
        banner
        echo -e "${PURPLE}┌────────────────────────────────────────────────────────────────────────────┐${NC}"
        echo -e "${PURPLE}│                        ${WHITE}[#] ${BOLD}THEME CUSTOMIZATION${NC}${PURPLE}                     │${NC}"
        echo -e "${PURPLE}├────────────────────────────────────────────────────────────────────────────┤${NC}"
        echo -e "${PURPLE}│${NC}                                                                        ${PURPLE}│${NC}"
        echo -e "${PURPLE}│${NC}  ${ORANGE}1)${NC} [*] Blueprint Theme                                 ${PURPLE}│${NC}"
        echo -e "${PURPLE}│${NC}  ${ORANGE}2)${NC} [>] Change Theme                                    ${PURPLE}│${NC}"
        echo -e "${PURPLE}│${NC}  ${ORANGE}3)${NC} [X] Uninstall Theme                                 ${PURPLE}│${NC}"
        echo -e "${PURPLE}│${NC}  ${ORANGE}4)${NC} [<] Back to Main Menu                               ${PURPLE}│${NC}"
        echo -e "${PURPLE}│${NC}                                                                        ${PURPLE}│${NC}"
        echo -e "${PURPLE}└────────────────────────────────────────────────────────────────────────────┘${NC}"
        echo
        echo -e "${DIM}Select an option [1-4]:${NC} "
        echo -ne "${CYAN}> ${NC}"
        read -p "" thchoice

        case $thchoice in
            1) execute_command "Blueprint Theme" "blueprint.sh" ;;
            2) execute_command "Change Theme" "change_theme.sh" ;;
            3) execute_command "Uninstall Theme" "theme_uninstall.sh" ;;
            4) break ;;
            *) echo -e "${RED}[!] Invalid choice! Please select between 1-4${NC}"; pause ;;
        esac
    done
}

# --- UNINSTALL MENU ---
uninstall_menu() {
    while true; do
        banner
        echo -e "${RED}┌────────────────────────────────────────────────────────────────────────────┐${NC}"
        echo -e "${RED}│                      ${WHITE}[#] ${BOLD}UNINSTALL MANAGER${NC}${RED}                         │${NC}"
        echo -e "${RED}├────────────────────────────────────────────────────────────────────────────┤${NC}"
        echo -e "${RED}│${NC}                                                                        ${RED}│${NC}"
        echo -e "${RED}│${NC}  ${YELLOW}1)${NC} [W] Pterodactyl               ${YELLOW}8)${NC} [@] CPanel                ${RED}│${NC}"
        echo -e "${RED}│${NC}  ${YELLOW}2)${NC} [~] JackTera v3               ${YELLOW}9)${NC} [~] Tailscale             ${RED}│${NC}"
        echo -e "${RED}│${NC}  ${YELLOW}3)${NC} [~] JackTera v4               ${YELLOW}10)${NC} [*] Cloudflare           ${RED}│${NC}"
        echo -e "${RED}│${NC}  ${YELLOW}4)${NC} [@] Dashboard v3              ${YELLOW}11)${NC} [@] IPv4                 ${RED}│${NC}"
        echo -e "${RED}│${NC}  ${YELLOW}5)${NC} [@] Dashboard v4              ${YELLOW}12)${NC} [>] Port Forward         ${RED}│${NC}"
        echo -e "${RED}│${NC}  ${YELLOW}6)${NC} [$] Payment                   ${YELLOW}13)${NC} [<] Back to Main Menu    ${RED}│${NC}"
        echo -e "${RED}│${NC}  ${YELLOW}7)${NC} [&] CtrlPanel                                         ${RED}│${NC}"
        echo -e "${RED}│${NC}                                                                        ${RED}│${NC}"
        echo -e "${RED}└────────────────────────────────────────────────────────────────────────────┘${NC}"
        echo
        echo -e "${DIM}Select an option [1-13]:${NC} "
        echo -ne "${CYAN}> ${NC}"
        read -p "" uchoice

        case $uchoice in
            1) execute_command "Uninstall Pterodactyl" "uninstall_ptero.sh" ;;
            2) execute_command "Uninstall JackTera v3" "uninstall_jacktera_v3.sh" ;;
            3) execute_command "Uninstall JackTera v4" "uninstall_jacktera_v4.sh" ;;
            4) execute_command "Uninstall Dashboard v3" "uninstall_dash_v3.sh" ;;
            5) execute_command "Uninstall Dashboard v4" "uninstall_dash_v4.sh" ;;
            6) execute_command "Uninstall Payment" "uninstall_payment.sh" ;;
            7) execute_command "Uninstall CtrlPanel" "uninstall_ctrlpanel.sh" ;;
            8) execute_command "Uninstall CPanel" "uninstall_cpanel.sh" ;;
            9) execute_command "Uninstall Tailscale" "uninstall_tailscale.sh" ;;
            10) execute_command "Uninstall Cloudflare" "uninstall_cloudflare.sh" ;;
            11) execute_command "Uninstall IPv4" "uninstall_ipv4.sh" ;;
            12) execute_command "Uninstall Port Forward" "uninstall_portforward.sh" ;;
            13) break ;;
            *) echo -e "${RED}[!] Invalid choice! Please select between 1-13${NC}"; pause ;;
        esac
    done
}

# --- COMMAND EXECUTION FUNCTION ---
execute_command() {
    local name="$1"
    local script="$2"
    echo -e "${YELLOW}[>] Starting $name...${NC}"
    sleep 1
    # Simulate execution - replace with actual command
    if bash <(curl -s "https://raw.githubusercontent.com/yourlink/$script") & then
        local pid=$!
        show_loading $pid "Installing $name"
    else
        echo -e "${RED}[!] Failed to execute $name${NC}"
    fi
    pause
}

# --- MAIN MENU ---
main_menu() {
    while true; do
        banner
        echo -e "${CYAN}┌────────────────────────────────────────────────────────────────────────────┐${NC}"
        echo -e "${CYAN}│                     ${WHITE}[#] ${BOLD}MAIN CONTROL PANEL${NC}${CYAN}                         │${NC}"
        echo -e "${CYAN}├────────────────────────────────────────────────────────────────────────────┤${NC}"
        echo -e "${CYAN}│${NC}                                                                        ${CYAN}│${NC}"
        echo -e "${CYAN}│${NC}  ${BLUE}1)${NC} [#] Panel Management                                  ${CYAN}│${NC}"
        echo -e "${CYAN}│${NC}  ${BLUE}2)${NC} [W] Wings Installation                                ${CYAN}│${NC}"
        echo -e "${CYAN}│${NC}  ${BLUE}3)${NC} [*] System Tools                                       ${CYAN}│${NC}"
        echo -e "${CYAN}│${NC}  ${BLUE}4)${NC} [@] Theme Customization                               ${CYAN}│${NC}"
        echo -e "${CYAN}│${NC}  ${BLUE}5)${NC} [X] Uninstall Manager                                 ${CYAN}│${NC}"
        echo -e "${CYAN}│${NC}  ${BLUE}6)${NC} [Q] Exit                                              ${CYAN}│${NC}"
        echo -e "${CYAN}│${NC}                                                                        ${CYAN}│${NC}"
        echo -e "${CYAN}└────────────────────────────────────────────────────────────────────────────┘${NC}"
        echo
        echo -e "${DIM}Choose your action [1-6]:${NC} "
        echo -ne "${CYAN}> ${NC}"
        read -p "" choice

        case $choice in
            1) panel_menu ;;
            2) execute_command "Wings Installation" "wings.sh" ;;
            3) tools_menu ;;
            4) theme_menu ;;
            5) uninstall_menu ;;
            6) 
                echo -e "${GREEN}"
                echo -e "┌────────────────────────────────────────────────────────────────────────────┐"
                echo -e "│                            [+] Thank You!                                  │"
                echo -e "│                  [#] Keandr Coding Hub                                     │"
                echo -e "│           [>] Visit again for more amazing tools!                         │"
                echo -e "└────────────────────────────────────────────────────────────────────────────┘"
                echo -e "${NC}"
                exit 0 
                ;;
            *) 
                echo -e "${RED}"
                echo -e "┌────────────────────────────────────────────────────────────────────────────┐"
                echo -e "│                          [!] INVALID INPUT                                │"
                echo -e "│                  Please select a valid option (1-6)                       │"
                echo -e "└────────────────────────────────────────────────────────────────────────────┘"
                echo -e "${NC}"
                pause 
                ;;
        esac
    done
}

# --- START SCRIPT ---
main_menu
