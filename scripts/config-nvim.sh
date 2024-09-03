#!/bin/bash

source "$(dirname "$0")/utils.sh"

PACKAGE_MANAGER=$1
if [[ "$PACKAGE_MANAGER" == "apt" ]]; then
    APP_NAME="nvim"
elif [[ "$PACKAGE_MANAGER" == "brew" ]]; then
    APP_NAME="neovim"
fi

function set_config() {
    if [ -d "$HOME/.config/nvim" ]; then
        echo_warn "remove existing $HOME/.config/nvim"
        rm -rf $HOME/.config/nvim
    fi

    cd "$(dirname "$0")/../" && stow $STOW_OPTIONS nvim
    echo_info "stow nvim config successfully."
}

# check installed
check_app_installed "$APP_NAME"
if [ $? -eq 0 ]; then
    echo_info "Skipping installation steps for $APP_NAME."
    set_config
    exit 0
fi

function install_nvim() {
    trap 'return 1' ERR
    
    echo_info "Downloading $APP_NAME..."
    wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz

    echo_info "Removing old $APP_NAME installation..."
    sudo rm -rf /opt/nvim

    echo_info "Installing $APP_NAME..."
    sudo tar -C /opt -xzf nvim-linux64.tar.gz

    echo_info "Cleanup..."
    rm -rf nvim-linux64.tar.gz

    echo_info "$APP_NAME installed successfully."
}

# install
if [[ "$PACKAGE_MANAGER" == "apt" ]]; then
    install_nvim
    if [ $? -ne 0 ]; then
        echo_error "$APP_NAME installation failed."
        exit 1
    fi
elif [[ "$PACKAGE_MANAGER" == "brew" ]]; then
    brew install $APP_NAME
    if [ $? -ne 0 ]; then
        echo_error "$APP_NAME installation failed."
        exit 1
    fi
fi

set_config
exit 0