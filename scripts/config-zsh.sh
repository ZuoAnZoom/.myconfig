#!/bin/bash

source "$(dirname "$0")/utils.sh"

PACKAGE_MANAGER=$1
APP_NAME="zsh"

function set_config() {
    if [ -f "$HOME/.zshrc" ]; then
        echo_warn "remove existing $HOME/.zshrc"
        rm -rf $HOME/.zshrc
    fi
    
    cd "$(dirname "$0")/../" && stow $STOW_OPTIONS zsh
    echo_info "stow zsh config successfully."
}

function install_oh_my_zsh() {
    trap 'return 1' ERR

    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo_info "oh my zsh already installed."
        return 0
    fi

    echo_info "Installing oh my zsh..."
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
}

function install_zsh_autosuggestions() {
    trap 'return 1' ERR

    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        echo_info "zsh-autosuggestions already installed."
        return 0
    fi
    
    echo_info "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

# check installed
check_app_installed "$APP_NAME"
if [ $? -eq 0 ]; then
    echo_info "Skipping installation steps for $APP_NAME."

    install_oh_my_zsh
    if [ $? -ne 0 ]; then
        echo_error "oh my zsh installation failed."
        exit 1
    fi

    install_zsh_autosuggestions
    if [ $? -ne 0 ]; then
        echo_warn "zsh_autosuggestions installation failed."
    fi

    set_config

    exit 0
fi


# install
if [[ "$PACKAGE_MANAGER" == "apt" ]]; then
    sudo apt install -y $APP_NAME
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

install_oh_my_zsh
if [ $? -ne 0 ]; then
    echo_error "oh my zsh installation failed."
    exit 1
fi

install_zsh_autosuggestions
if [ $? -ne 0 ]; then
    echo_warn "zsh_autosuggestions installation failed."
fi

# check install
check_app_installed "$APP_NAME"
if [ $? -ne 0 ]; then
    exit 1
else
    set_config
    exit 0
fi