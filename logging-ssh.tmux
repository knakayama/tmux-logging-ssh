#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

ssh_key() {
  local ssh_default_key="S"
  local ssh_option="@ssh"
  local ssh_optional_key="$(tmux show-option -gqv "$ssh_option")"

  if [[ -n "$ssh_optional_key" ]]; then
    echo "$ssh_optional_key"
  else
    echo "$ssh_default_key"
  fi
}

tmux bind-key "$(ssh_key)" command-prompt -p "hostname:" "run-shell '${CURRENT_DIR}/scripts/ssh.sh %%'"
