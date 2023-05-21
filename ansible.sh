#!/usr/bin/env bash

set -euoE pipefail

cwd="$HOME/.dotfiles"

_usage() {
    printf "
Usage:
  my -h, --help
  my COMMAND [ARGS]
  [ARGS] are ansible-playbook args

COMMAND:
  run             [ARGS]   Run playbook with args on local pc
  dotfiles_link   [ARGS]   Only link dotfiles, without running other playbook steps
  dotfiles_unlink [ARGS]   Only unlink dotfiles, without running other playbook steps
  ansible_deps    [ARGS]   Install ansible dependencies for this playbook
  run_remote      [ARGS]   Run playbook with args on remote pc, using 'inventory' file
    \n"
}

_install_ansible_deps() {
    echo "⚪ [ansible] installing deps..."
    ansible-galaxy install -r $cwd/requirements.yaml
    if [ ! -f "$cwd/library/stow" ]; then
        wget https://raw.githubusercontent.com/caian-org/ansible-stow/v1.1.0/stow
        mkdir -p "$cwd/library"
        mv stow "$cwd/library"
    fi
    echo "✅ [ansible] deps installed!"
}

_run_playbook() {
    echo "⚪ [ansible] running playbook..."
    local playbook_opts=(
        "--inventory=$cwd/inventory"
        "$cwd/main.yaml"
    )
    playbook_opts+=($@)
    echo "parameters: ${playbook_opts[*]}"
    ANSIBLE_CONFIG="$cwd/ansible.cfg" ansible-playbook ${playbook_opts[*]}
    echo "✅ [ansible] configured!"
}

command="${1-}"
case $command in
    run)
        _run_playbook -K "${@:2}"
        ;;
    run_remote)
        _run_playbook -Kk -e hosts_var=remote_servers "${@:2}"
        ;;
    theme)
        _run_playbook --tags "theme" "${@:2}"
        ;;
    dotfiles_link)
        _run_playbook --tags "dotfiles" "${@:2}"
        ;;
    dotfiles_unlink)
        _run_playbook --tags "dotfiles" -e dotfiles_state=absent "${@:2}"
        ;;
    ansible_deps)
        _install_ansible_deps
        ;;
    "" | -h | --help | *)
        _usage
        ;;
esac
