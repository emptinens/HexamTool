#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Remote JSON file URL
REPO_URL="https://raw.githubusercontent.com/emptinens/HexamTool/main/apps.json"

# Function to fetch the repository data
fetch_repo_data() {
    if ! command -v curl &> /dev/null; then
        echo -e "${RED}curl is required to fetch data from the repository. Please install curl.${NC}"
        exit 1
    fi
    curl -s "$REPO_URL"
}

# Function to display animated banner
animated_banner() {
    echo -e "${CYAN}"
    echo "   ██╗  ██╗███████╗██╗  ██╗ █████╗ ███╗   ███╗"
    echo "   ██║  ██║██╔════╝██║  ██║██╔══██╗████╗ ████║"
    echo "   ███████║█████╗  ███████║███████║██╔████╔██║"
    echo "   ██╔══██║██╔══╝  ██╔══██║██╔══██║██║╚██╔╝██║"
    echo "   ██║  ██║███████╗██║  ██║██║  ██║██║ ╚═╝ ██║"
    echo "   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝"
    echo -e "${NC}"
    sleep 0.5
    clear
    echo -e "${MAGENTA}"
    echo "   ██████╗ ███████╗██╗   ██╗███████╗██╗  ██╗"
    echo "   ██╔══██╗██╔════╝██║   ██║██╔════╝██║  ██║"
    echo "   ██████╔╝█████╗  ██║   ██║███████╗███████║"
    echo "   ██╔══██╗██╔══╝  ██║   ██║╚════██║██╔══██║"
    echo "   ██║  ██║███████╗╚██████╔╝███████║██║  ██║"
    echo "   ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝"
    echo -e "${NC}"
    sleep 0.5
    clear
}

# Function to detect the Linux distribution
detect_distro() {
    if command -v apt &> /dev/null; then
        echo "debian"
    elif command -v pacman &> /dev/null; then
        echo "arch"
    else
        echo "unsupported"
    fi
}

# Function to install packages based on the distribution
install_package() {
    local package=$1
    case $DISTRO in
        debian)
            sudo apt install -y "$package"
            ;;
        arch)
            sudo pacman -S --noconfirm "$package"
            ;;
        *)
            echo -e "${RED}Unsupported distribution. Exiting...${NC}"
            exit 1
            ;;
    esac
}

# Function to display the main menu
main_menu() {
    clear
    animated_banner
    echo -e "${GREEN}=============================================${NC}"
    echo -e "${YELLOW}    Hexam Toolbox - Linux App Installer${NC}"
    echo -e "${GREEN}=============================================${NC}"
    echo
    echo -e "${CYAN}Select a category to proceed:${NC}"
    echo
    echo -e "${BLUE}1. Install Runtimes${NC}"
    echo -e "${BLUE}2. Install Media Apps${NC}"
    echo -e "${BLUE}3. Install Browsers${NC}"
    echo -e "${BLUE}4. Install Games & Gaming Platforms${NC}"
    echo -e "${BLUE}5. Install Development Tools${NC}"
    echo -e "${BLUE}6. Install Communication Apps${NC}"
    echo -e "${BLUE}7. Install Productivity Apps${NC}"
    echo -e "${BLUE}8. Install Photo & Video Editing Apps${NC}"
    echo -e "${BLUE}9. Install Utilities${NC}"
    echo -e "${BLUE}10. Exit${NC}"
    echo
    read -p "Enter your choice (1-10): " choice

    case $choice in
        1) category_menu "runtimes" ;;
        2) category_menu "media" ;;
        3) category_menu "browsers" ;;
        4) category_menu "games" ;;
        5) category_menu "development" ;;
        6) category_menu "communication" ;;
        7) category_menu "productivity" ;;
        8) category_menu "photo_video" ;;
        9) category_menu "utilities" ;;
        10) exit 0 ;;
        *) echo -e "${RED}Invalid choice. Please try again.${NC}" ;;
    esac
    main_menu
}

# Function to display a category menu
category_menu() {
    local category=$1
    clear
    echo -e "${GREEN}=============================================${NC}"
    echo -e "${YELLOW}    Install ${category^} Apps${NC}"
    echo -e "${GREEN}=============================================${NC}"
    echo

    # Fetch the repository data
    repo_data=$(fetch_repo_data)
    if [[ -z "$repo_data" ]]; then
        echo -e "${RED}Failed to fetch data from the repository. Exiting...${NC}"
        exit 1
    fi

    # Parse the JSON data for the selected category
    apps=$(echo "$repo_data" | jq -r ".${category}[]")
    if [[ -z "$apps" ]]; then
        echo -e "${RED}No apps found for this category. Exiting...${NC}"
        exit 1
    fi

    # Display the apps in the category
    count=1
    declare -A app_map
    for app in $apps; do
        echo -e "${CYAN}${count}. Install ${app}${NC}"
        app_map["$count"]="$app"
        ((count++))
    done
    echo -e "${CYAN}${count}. Back to Main Menu${NC}"
    echo
    read -p "Enter your choice (1-${count}): " choice

    if [[ "$choice" -eq "$count" ]]; then
        main_menu
    elif [[ -n "${app_map[$choice]}" ]]; then
        install_package "${app_map[$choice]}"
    else
        echo -e "${RED}Invalid choice. Please try again.${NC}"
    fi
    category_menu "$category"
}

# Detect the Linux distribution
DISTRO=$(detect_distro)

# Check if the distribution is supported
if [[ "$DISTRO" == "unsupported" ]]; then
    echo -e "${RED}Unsupported Linux distribution. Exiting...${NC}"
    exit 1
fi

# Start the main menu
main_menu
