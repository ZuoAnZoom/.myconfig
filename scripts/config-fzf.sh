#!/bin/bash

source "$(dirname "$0")/utils.sh"

PACKAGE_MANAGER=$1
APP_NAME="fzf"

# check installed
check_app_installed "$APP_NAME"
if [ $? -eq 0 ]; then
    echo_info "Skipping installation steps for $APP_NAME."
    exit 0
fi

function install_fzf() {
    trap 'return 1' ERR

    if [ -d "$HOME/.fzf" ]; then
        echo_info "$APP_NAME already installed."
        return 0
    fi

    echo_info "Cloning $APP_NAME..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

    echo_info "Installing $APP_NAME..."
    ~/.fzf/install

    echo_info "$APP_NAME installed successfully."
}

# install
if [[ "$PACKAGE_MANAGER" == "apt" ]]; then
    install_fzf
    if [ $? -ne 0 ]; then
        echo_error "$APP_NAME installation failed."
        exit 1
    fi
    sudo apt install -y dnsutils tree bat
    if [ $? -ne 0 ]; then
        echo_warn "dnsutils tree bat install failed."
    fi
elif [[ "$PACKAGE_MANAGER" == "brew" ]]; then
    brew install $APP_NAME
    if [ $? -ne 0 ]; then
        echo_error "$APP_NAME installation failed."
        exit 1
    fi
    brew install tree bat
    if [ $? -ne 0 ]; then
        echo_error "tree bat install failed."
    fi
fi


exit 0