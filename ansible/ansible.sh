#!/usr/bin/env bash

set -euoE pipefail

cwd="$HOME/.dotfiles/ansible"

install_collections() {
	echo "⚪ [ansible] installing collections..."
	ansible-galaxy install -r $cwd/requirements.yaml
	if [ ! -f "$cwd/library/stow" ]; then
		wget https://raw.githubusercontent.com/caian-org/ansible-stow/v1.1.0/stow
		mkdir -p "$cwd/library"
		mv stow "$cwd/library"
	fi
}

run_playbook() {
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

while [[ $# -gt 0 ]]; do
	arg=$1
	case $arg in
	--install)
		install_collections
		break
		;;
	--run)
		shift
		run_playbook $@
		break
		;;
	--dotfiles)
		shift
		run_playbook --tags "dotfiles" $@
		break
		;;
	--clean-dotfiles)
		shift
		run_playbook --tags "dotfiles" -e dotfiles_state=absent $@
		break
		;;
	--all)
		shift
		install_collections
		run_playbook -K $@
		break
		;;
	esac
done
