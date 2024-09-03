#!/bin/bash

source "$(dirname "$0")/utils.sh"

PACKAGE_MANAGER=$1
APP_NAME="wget"


# check installed
check_app_installed "$APP_NAME"
if [ $? -eq 0 ]; then
    echo_info "Skipping installation steps for $APP_NAME."
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

# check install
check_app_installed "$APP_NAME"
if [ $? -ne 0 ]; then
    exit 1
else
    exit 0
fi