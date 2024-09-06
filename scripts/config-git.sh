#!/bin/bash

source "$(dirname "$0")/utils.sh"

PACKAGE_MANAGER=$1
APP_NAME="git"

function install_git_delta() {
    check_app_installed "delta"
    if [ $? -eq 0 ]; then
        echo_info "Skipping installation steps for git-delta."
        return 0
    fi

    trap 'return 1' ERR

    arch=$(uname -m)
    echo_info "Installing git_delta ..."
    if [[ "$PACKAGE_MANAGER" == "apt" ]]; then
        if [[ "$arch" == "x86_64" ]]; then
            wget -O git-delta.dpkg https://github.com/dandavison/delta/releases/download/0.18.1/git-delta_0.18.1_amd64.deb
            sudo dpkg -i git-delta.dpkg
            rm -rf git-delta.dpkg
        else
            echo_warn "Unsupported architecture: $arch to install git-delta. Please install it manually."
        fi
    elif [[ "$PACKAGE_MANAGER" == "brew" ]]; then
        brew install git-delta
        if [ $? -ne 0 ]; then
            echo_warning "git-delta installation failed."
        fi
    fi
}

function set_config() {
    if [ -f "$HOME/.gitconfig" ]; then
        echo_warn "remove existing $HOME/.gitconfig"
        rm -rf $HOME/.gitconfig
    fi

    cd "$(dirname "$0")/../" && stow $STOW_OPTIONS git 
    echo_info "stow git config successfully."
}


# check installed
check_app_installed "$APP_NAME"
if [ $? -eq 0 ]; then
    echo_info "Skipping installation steps for $APP_NAME."

    install_git_delta
    set_config

    exit 0
fi

install_git_delta

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

# check install
check_app_installed "$APP_NAME"
if [ $? -ne 0 ]; then
    exit 1
else
    set_config
    exit 0
fi
