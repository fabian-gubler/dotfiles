#!/bin/bash
set -e

DOTFILES_DIR="$HOME/.dotfiles"
SSH_DIR="$HOME/.ssh"
EMAIL="fabian.gubler@proton.me"

# install ansible
if ! [ -x "$(command -v ansible)" ]; then
	sudo dnf install ansible -y
fi

# ssh
if ! [[ -f "$SSH_DIR/id_rsa" ]]; then
  mkdir -p "$SSH_DIR"

  chmod 700 "$SSH_DIR"

  ssh-keygen -b 4096 -t rsa -f "$SSH_DIR/id_rsa" -N "" -C "$USER@$HOSTNAME"

  cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"

  chmod 600 "$SSH_DIR/authorized_keys"
fi

# change directory into the dotfiles folder
cd "$DOTFILES_DIR"

# run the playbook
ansible-playbook --diff "$DOTFILES_DIR/main.yml" --ask-become-pass --verbose
