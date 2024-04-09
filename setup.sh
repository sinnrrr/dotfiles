#!/usr/bin/env bash

set -euoE pipefail

source="https://github.com/Keep-Simple/.dotfiles"
branch="${branch:-macos}"
tarball="$source/tarball/$branch"
target="$HOME/.dotfiles"
tar_cmd="tar -xzv -C $target --strip-components=1 --exclude='{.gitignore}'"

exit_help() {
    echo "Error: $1"
    exit 1
}

macos() { test "$(uname -s)" == "Darwin" && return 0; }
linux() { test "$(uname -s)" == "Linux" && return 0; }
is_executable() { type "$1" >/dev/null 2>&1; }

download_repository() {
    if is_executable "git"; then
        cmd="git clone -b $branch $source $target"
    elif is_executable "curl"; then
        cmd="curl -#L $tarball | $tar_cmd"
    elif is_executable "wget"; then
        cmd="wget --no-check-certificate -O - $tarball | $tar_cmd"
    fi

    if test -z "$cmd"; then
        exit_help "No git, curl or wget available. Aborting."
    else
        mkdir -p "$target"
        eval "$cmd"
    fi
}

install_brew() {
    if hash brew 2>/dev/null; then
        echo "⚪ [homebrew] already installed."
    else
        pgrep caffeinate >/dev/null || (caffeinate -d -i -m -u &)
        sudo --validate # reset `sudo` timeout
        echo "⚪ [homebrew] installing..."
        echo "[INFO] Installing rosetta 2"
        softwareupdate --install-rosetta --agree-to-license
        echo "[INFO] Installing xcode cli"
        xcode-select --install
        echo "[INFO] Installing Homebrew package manager..."
        export NONINTERACTIVE=1
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        /opt/homebrew/bin/brew analytics off
        echo "✅ [homebrew] installed!"
    fi
}

debian_deps() {
    export DEBIAN_FRONTEND=noninteractive
    packages=(
        # Bare Necessities
        ca-certificates
        git
        gpg
        locales
        make
        software-properties-common
        sudo
        # Editor
        vim
        # Download Manager
        curl
        wget
        # Ansible
        ansible
    )
    echo "⚪ [apt] installing packages: ${packages[*]}"
    apt --no-install-recommends --assume-yes install ${packages[*]}
    echo "✅ [apt] installed packages!"
}

macos_deps() {
    install_brew
    /opt/homebrew/bin/brew install ansible wget
}

install_deps() {
    if linux; then
        debian_deps
    fi
    if macos; then
        install_brew
    fi
}

run_full_ansible_playbook() {
    "${target}/ansible.sh" ansible_deps
    "${target}/ansible.sh" run
}

install_deps              # for local setup, we need to somehow install ansible before running it
download_repository       # ansible needs playbook files to run
run_full_ansible_playbook # run ansible playbook locally
