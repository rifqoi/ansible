#!/bin/bash

ANSIBLE_DIR="$HOME/ansible"

# Update ansible galaxy
ansible-galaxy install -r requirements.yaml

# Run playbook
if [[ -f "$CONFIG_DIR/vault-password.txt" ]]; then
  ansible-playbook --diff --extra-vars "@$ANSIBLE_DIR/values.yaml" --vault-password-file "$ANSIBLE_DIR/vault-password.txt" "$ANSIBLE_DIR/main.yaml" "$@"
else
  ansible-playbook --diff --extra-vars "@$ANSIBLE_DIR/values.yaml" "$ANSIBLE_DIR/main.yaml" "$@"
fi
