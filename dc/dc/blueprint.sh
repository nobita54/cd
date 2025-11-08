#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
ORANGE='\033[0;33m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Background colors
BG_BLUE='\033[44m'
BG_CYAN='\033[46m'
BG_GREEN='\033[42m'
BG_RED='\033[41m'
BG_YELLOW='\033[43m'

# Function to print section headers
print_header() {
    echo -e "\n${BG_BLUE}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BG_BLUE}${WHITE}   $1   ${NC}"
    echo -e "${BG_BLUE}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Function to print status messages
print_status() {
    echo -e "${YELLOW}⏳ $1...${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${ORANGE}⚠️  $1${NC}"
}

print_info() {
    echo -e "${CYAN}💡 $1${NC}"
}

# Function to check if command succeeded
check_success() {
    if [ $? -eq 0 ]; then
        print_success "$1"
        return 0
    else
        print_error "$2"
        return 1
    fi
}

# Function to animate progress
animate_progress() {
    local pid=$1
    local message=$2
    local delay=0.1
    local spinstr='|/-\'
    
    echo -e -n "${CYAN}$message ${NC}"
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Welcome animation
welcome_animation() {
    clear
    echo -e "${BG_CYAN}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BG_CYAN}${WHITE}                                                  ${NC}"
    echo -e "${BG_CYAN}${WHITE}   ███╗   ██╗ ██████╗ ██████╗ ██╗████████╗ █████╗ ${NC}"
    echo -e "${BG_CYAN}${WHITE}   ████╗  ██║██╔═══██╗██╔══██╗██║╚══██╔══╝██╔══██╗${NC}"
    echo -e "${BG_CYAN}${WHITE}   ██╔██╗ ██║██║   ██║██████╔╝██║   ██║   ███████║${NC}"
    echo -e "${BG_CYAN}${WHITE}   ██║╚██╗██║██║   ██║██╔══██╗██║   ██║   ██╔══██║${NC}"
    echo -e "${BG_CYAN}${WHITE}   ██║ ╚████║╚██████╔╝██║  ██║██║   ██║   ██║  ██║${NC}"
    echo -e "${BG_CYAN}${WHITE}   ╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝${NC}"
    echo -e "${BG_CYAN}${WHITE}                                                  ${NC}"
    echo -e "${BG_CYAN}${WHITE}           🚀 Blueprint Installer v2.0            ${NC}"
    echo -e "${BG_CYAN}${WHITE}                                                  ${NC}"
    echo -e "${BG_CYAN}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    sleep 2
}

# Function: Install (Fresh Setup)
install_nobita() {
    print_header "🚀 FRESH INSTALLATION"
    
    if [ "$EUID" -ne 0 ]; then
        print_error "Please run this script as root or with sudo"
        return 1
    fi

    print_info "This will install Nobita Hosting with all dependencies"
    echo -e "${YELLOW}┌─────────────────────────────────────────────┐${NC}"
    echo -e "${YELLOW}│ 📋 Installation Steps:                      │${NC}"
    echo -e "${YELLOW}│ • Node.js 20.x                              │${NC}"
    echo -e "${YELLOW}│ • Yarn & Dependencies                       │${NC}"
    echo -e "${YELLOW}│ • Nobita Hosting Framework                  │${NC}"
    echo -e "${YELLOW}│ • Blueprint Installer                       │${NC}"
    echo -e "${YELLOW}└─────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "$(echo -e "${YELLOW}Continue with installation? (y/N): ${NC}")" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Installation cancelled"
        return 1
    fi

    print_status "Starting Fresh Install for Nobita Hosting"

    # --- Step 1: Install Node.js 20.x ---
    print_header "📥 INSTALLING NODE.JS 20.x"
    print_status "Installing required packages"
    sudo apt-get install -y ca-certificates curl gnupg > /dev/null 2>&1 &
    animate_progress $! "Installing dependencies"
    
    print_status "Setting up Node.js repository"
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | \
      sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg > /dev/null 2>&1
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | \
      sudo tee /etc/apt/sources.list.d/nodesource.list > /dev/null 2>&1
      
    print_status "Updating package lists"
    sudo apt-get update > /dev/null 2>&1 &
    animate_progress $! "Updating package lists"
    
    print_status "Installing Node.js"
    sudo apt-get install -y nodejs > /dev/null 2>&1 &
    animate_progress $! "Installing Node.js"
    check_success "Node.js installed" "Failed to install Node.js"

    # --- Step 2: Install Yarn, Dependencies & Nobita Hosting Release ---
    print_header "📦 INSTALLING DEPENDENCIES"
    print_status "Installing Yarn"
    npm i -g yarn > /dev/null 2>&1 &
    animate_progress $! "Installing Yarn"
    check_success "Yarn installed" "Failed to install Yarn"

    print_status "Changing to panel directory"
    cd /var/www/pterodactyl || { print_error "Panel directory not found!"; return 1; }
    
    print_status "Installing Yarn dependencies"
    yarn > /dev/null 2>&1 &
    animate_progress $! "Installing Yarn dependencies"
    check_success "Yarn dependencies installed" "Failed to install Yarn dependencies"

    print_status "Installing additional packages"
    sudo apt install -y zip unzip git curl wget > /dev/null 2>&1 &
    animate_progress $! "Installing additional packages"
    check_success "Additional packages installed" "Failed to install additional packages"

    # --- Step 3: Download and Extract Release ---
    print_header "⬇️ DOWNLOADING NOBITA HOSTING"
    print_status "Downloading latest release"
    wget "$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest | \
    grep 'browser_download_url' | cut -d '"' -f 4)" -O release.zip > /dev/null 2>&1 &
    animate_progress $! "Downloading release"
    check_success "Release downloaded" "Failed to download release"

    print_status "Extracting release files"
    unzip -o release.zip > /dev/null 2>&1 &
    animate_progress $! "Extracting files"
    check_success "Files extracted" "Failed to extract files"

    # --- Step 4: Run Nobita Hosting Installer ---
    print_header "🔧 RUNNING BLUEPRINT INSTALLER"
    if [ ! -f "blueprint.sh" ]; then
        print_error "blueprint.sh not found in release package"
        return 1
    fi

    print_status "Making blueprint.sh executable"
    chmod +x blueprint.sh
    check_success "Made executable" "Failed to make executable"

    print_status "Running Blueprint installer"
    bash blueprint.sh
}

# Function: Reinstall (Rerun Only)
reinstall_nobita() {
    print_header "🔄 REINSTALLING NOBITA HOSTING"
    print_info "This will rerun the Nobita Hosting installation"
    echo ""
    
    read -p "$(echo -e "${YELLOW}Continue with reinstallation? (y/N): ${NC}")" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Reinstallation cancelled"
        return 1
    fi

    print_status "Starting reinstallation"
    blueprint -rerun-install > /dev/null 2>&1 &
    animate_progress $! "Reinstalling Nobita Hosting"
    check_success "Reinstallation completed" "Reinstallation failed"
}

# Function: Update Nobita Hosting
update_nobita() {
    print_header "📥 UPDATING NOBITA HOSTING"
    print_info "This will update Nobita Hosting to the latest version"
    echo ""
    
    read -p "$(echo -e "${YELLOW}Continue with update? (y/N): ${NC}")" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Update cancelled"
        return 1
    fi

    print_status "Starting update"
    blueprint -upgrade > /dev/null 2>&1 &
    animate_progress $! "Updating Nobita Hosting"
    check_success "Update completed" "Update failed"
}

# Function: Reset & Upgrade
reset_upgrade() {
    print_header "🔄 RESET & UPGRADE"
    print_info "This will reset and upgrade Nobita Hosting"
    print_warning "This operation will change to panel directory and run upgrade command"
    echo ""
    
    echo -e "${YELLOW}┌─────────────────────────────────────────────┐${NC}"
    echo -e "${YELLOW}│ 🔄 Commands to be executed:                 │${NC}"
    echo -e "${YELLOW}│ • cd /var/www/pterodactyl                   │${NC}"
    echo -e "${YELLOW}│ • blueprint -upgrade                        │${NC}"
    echo -e "${YELLOW}└─────────────────────────────────────────────┘${NC}"
    echo ""
    
    read -p "$(echo -e "${YELLOW}Continue with reset & upgrade? (y/N): ${NC}")" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Reset & upgrade cancelled"
        return 1
    fi

    print_status "Changing to panel directory"
    cd /var/www/pterodactyl > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        print_error "Failed to change to panel directory: /var/www/pterodactyl"
        return 1
    fi
    check_success "Changed to panel directory" "Failed to change directory"

    print_status "Running blueprint upgrade"
    blueprint -upgrade
    check_success "Reset & upgrade completed" "Reset & upgrade failed"
}

# Function: Show System Info
show_system_info() {
    print_header "💻 SYSTEM INFORMATION"
    
    echo -e "${CYAN}┌─────────────────────────────────────────────┐${NC}"
    echo -e "${CYAN}│ 🖥️  Hostname: ${WHITE}$(hostname)${NC}"
    echo -e "${CYAN}│ 🐧 OS: ${WHITE}$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')${NC}"
    echo -e "${CYAN}│ 🏗️  Architecture: ${WHITE}$(uname -m)${NC}"
    echo -e "${CYAN}│ 💾 Memory: ${WHITE}$(free -h | awk '/^Mem:/ {print $3 "/" $2}')${NC}"
    echo -e "${CYAN}│ 💿 Disk Usage: ${WHITE}$(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')${NC}"
    
    if command -v node &> /dev/null; then
        echo -e "${CYAN}│ ⚡ Node.js: ${WHITE}$(node -v)${NC}"
    else
        echo -e "${CYAN}│ ⚡ Node.js: ${RED}Not Installed${NC}"
    fi
    
    if command -v npm &> /dev/null; then
        echo -e "${CYAN}│ 📦 npm: ${WHITE}$(npm -v)${NC}"
    else
        echo -e "${CYAN}│ 📦 npm: ${RED}Not Installed${NC}"
    fi
    
    if command -v yarn &> /dev/null; then
        echo -e "${CYAN}│ 🧶 Yarn: ${WHITE}$(yarn -v)${NC}"
    else
        echo -e "${CYAN}│ 🧶 Yarn: ${RED}Not Installed${NC}"
    fi
    
    # Check if in panel directory
    if [ -d "/var/www/pterodactyl" ]; then
        echo -e "${CYAN}│ 📁 Panel Directory: ${GREEN}Exists${NC}"
    else
        echo -e "${CYAN}│ 📁 Panel Directory: ${RED}Missing${NC}"
    fi
    echo -e "${CYAN}└─────────────────────────────────────────────┘${NC}"
}

# Function to display the main menu
show_menu() {
    clear
    echo -e "${BG_BLUE}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BG_BLUE}${WHITE}                                                  ${NC}"
    echo -e "${BG_BLUE}${WHITE}           🚀 BLUEPRINT INSTALLER v2.0            ${NC}"
    echo -e "${BG_BLUE}${WHITE}              Nobita Hosting                      ${NC}"
    echo -e "${BG_BLUE}${WHITE}                                                  ${NC}"
    echo -e "${BG_BLUE}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e ""
    
    echo -e "${WHITE}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "${WHITE}║                📋 MAIN MENU                   ║${NC}"
    echo -e "${WHITE}╠═══════════════════════════════════════════════╣${NC}"
    echo -e "${WHITE}║   ${GREEN}1)${NC} ${CYAN}🚀 Fresh Install${NC}                      ${WHITE}║${NC}"
    echo -e "${WHITE}║   ${GREEN}2)${NC} ${CYAN}🔄 Reinstall (Rerun Only)${NC}             ${WHITE}║${NC}"
    echo -e "${WHITE}║   ${GREEN}3)${NC} ${CYAN}📥 Update Nobita Hosting${NC}              ${WHITE}║${NC}"
    echo -e "${WHITE}║   ${GREEN}4)${NC} ${CYAN}🔄 Reset & Upgrade${NC}                    ${WHITE}║${NC}"
    echo -e "${WHITE}║   ${GREEN}5)${NC} ${CYAN}💻 System Information${NC}                 ${WHITE}║${NC}"
    echo -e "${WHITE}║   ${GREEN}0)${NC} ${RED}🚪 Exit${NC}                            ${WHITE}║${NC}"
    echo -e "${WHITE}╚═══════════════════════════════════════════════╝${NC}"
    echo -e ""
    echo -e "${CYAN}┌─────────────────────────────────────────────┐${NC}"
    echo -e "${CYAN}│ 💡 Tip: Run option 1 for first-time setup   │${NC}"
    echo -e "${CYAN}│ 🔄 Option 4: Reset & upgrade panel          │${NC}"
    echo -e "${CYAN}└─────────────────────────────────────────────┘${NC}"
    echo -e ""
    echo -e "${BG_BLUE}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e -n "${YELLOW}🎯 Select an option [0-5]: ${NC}"
}

# Main execution
welcome_animation

while true; do
    show_menu
    read -r choice
    
    case $choice in
        1) 
            install_nobita 
            ;;
        2) 
            reinstall_nobita 
            ;;
        3) 
            update_nobita 
            ;;
        4) 
            reset_upgrade 
            ;;
        5) 
            show_system_info 
            ;;
        0) 
            echo -e ""
            echo -e "${GREEN}Exiting Blueprint Installer...${NC}"
            echo -e "${BG_GREEN}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            echo -e "${BG_GREEN}${WHITE}                                                  ${NC}"
            echo -e "${BG_GREEN}${WHITE}           Thank you for using our tools!         ${NC}"
            echo -e "${BG_GREEN}${WHITE}                                                  ${NC}"
            echo -e "${BG_GREEN}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            sleep 2
            exit 0 
            ;;
        *) 
            print_error "Invalid option! Please choose between 0-5"
            sleep 2
            ;;
    esac
    
    echo -e ""
    read -p "$(echo -e "${YELLOW}Press Enter to continue...${NC}")" -n 1
done
