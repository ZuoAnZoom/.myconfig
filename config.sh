#!/bin/bash

source "$(dirname "$0")/scripts/utils.sh"

# set proxy
proxy_ip=""
echo "Do you want to set up a proxy? (yes/no)"
read -t 5 user_input  # 5s timeout
user_input=$(echo "$user_input" | tr '[:upper:]' '[:lower:]')
if [[ "$user_input" == "yes" || "$user_input" == "y" ]]; then
    echo "Please enter the proxy IP address(x.x.x.x:port):"
    read proxy_ip

    if [ -n "$proxy_ip" ]; then
        export http_proxy="http://$proxy_ip"
        export https_proxy="http://$proxy_ip"
        echo "Proxy has been set to $proxy_ip"
    else
        echo "No proxy IP provided. Default No proxy."
    fi
else
    echo "Proxy setup skipped. Default No proxy."
fi


# check package manager installed
if command -v brew &> /dev/null; then
    echo_info "package manager: brew detected!"
    PACKAGE_MANAGER="brew"
elif command -v apt &> /dev/null; then
    echo_info "package manager: apt detected!"
    PACKAGE_MANAGER="apt"
else
    echo_error "no package manager detected! please install brew or apt!"
    exit 1
fi


if [[ "$PACKAGE_MANAGER" == "apt" ]]; then
    echo_info "sudo apt update"
    sudo apt update
    if [ $? -ne 0 ]; then
        echo_error "apt update failed!"
        exit 1
    fi
elif [[ "$PACKAGE_MANAGER" == "brew" ]]; then
    echo_info "brew update"
    brew update
    if [ $? -ne 0 ]; then
        echo_error "brew update failed!"
        exit 1
    fi
fi


user_apps=("$@")
required_apps=("stow" "wget" "git" "zsh" "tmux" "fzf")
all_apps=("${required_apps[@]}" "${user_apps[@]}")
failed_apps=()

SCRIPTS_DIR="$(dirname "$0")/scripts"

for app in "${all_apps[@]}"; do
    echo_info "************** $app ***************"
    if [[ ! -f "$SCRIPTS_DIR/config-$app.sh" ]]; then
        echo_error "config-$app.sh not found."
        failed_apps+=("$app")
        continue
    fi
    
    "$SCRIPTS_DIR/config-$app.sh" "$PACKAGE_MANAGER"

    if [ $? -ne 0 ]; then
        echo_error "$app config failed."
        failed_apps+=("$app")
    else
        echo_info "$app config done."
    fi
done
echo_info "***********************************"


if [ ${#failed_apps[@]} -eq 0 ]; then
    echo_info "All apps configured successfully: ${all_apps[*]}"
    exit 0
else
    echo_error "Configured failed apps: ${failed_apps[*]}"
    exit 1
fi