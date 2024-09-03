#!/bin/bash

STOW_OPTIONS="--verbose=2"

COLOR_RESET="\033[0m"
COLOR_INFO="\033[1;34m"  # blue
COLOR_WARN="\033[1;33m"  # yellow
COLOR_ERROR="\033[1;31m" # red
function echo_info() {
    echo -e "[$(basename "$0"):$LINENO]${COLOR_INFO}[INFO] $1${COLOR_RESET}"
}
function echo_warn() {
    echo -e "[$(basename "$0"):$LINENO]${COLOR_WARN}[WARN] $1${COLOR_RESET}"
}
function echo_error() {
    echo -e "[$(basename "$0"):$LINENO]${COLOR_ERROR}[ERROR] $1${COLOR_RESET}"
}

function check_app_installed() {
    local app_name="$1"

    if ! command -v "$app_name" &> /dev/null; then
        echo_warn "$app_name not installed!"
        return 1
    else
        echo_info "$app_name installed."
        return 0
    fi
}