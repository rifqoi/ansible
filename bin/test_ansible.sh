#!/bin/bash

# Update ansible galaxy
ansible-galaxy install -r requirements.yaml

# Run playbook
if [[ -f "vault-password.txt" ]]; then
  ansible-playbook \
      --diff \
      --extra-vars \
      "@values.yaml" \
      --vault-password-file \
      "vault-password.txt" \
      "main.yaml" \
      --syntax-check
else
  ansible-playbook \
      -K \
      --diff \
      --extra-vars \
      "@values.yaml" \
      "main.yaml" \
      --syntax-check
fi
