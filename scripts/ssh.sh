#!/usr/bin/env bash

ARGS="$@"

echo_err() {
  tmux display-message "Unknown Argument: $ARGS"
  exit 0
}

if [[ $(echo "$ARGS" | grep -cE '[[:space:]]') -eq 0 ]]; then
  ACTION="$ARGS"

  if echo "$ACTION" | grep -qE '^k$'; then
    HOST_NAME="kero"
  elif echo "$ACTION" | grep -qE '^c$'; then
    HOST_NAME="config"
  elif echo "$ACTION" | grep -qE '^o$'; then
    HOST_NAME="ops1"
  else
    echo_err
  fi
elif [[ $(echo "$ARGS" | grep -cE '[[:space:]]') -eq 1 ]]; then
  echo "$ARGS" | grep -qE '^(s|h|v) ' || echo_err

  ACTION="$(echo "$ARGS" | awk '{print $1}')"
  HOST_NAME="$(echo "$ARGS" | awk '{print $2}')"
else
  echo_err
fi

LOG_DIR="${HOME}/.tmux-ssh-logs/${HOST_NAME}/$(date '+%Y-%m/%d')"
LOG_FILE="${LOG_DIR}/$(date '+%H:%M:%S').log"

[[ -d "$LOG_DIR" ]] || mkdir -p "$LOG_DIR"
[[ $? -eq 0 ]]    || { tmux display-message "Can not create $LOG_DIR"; exit 0; }

case "$ACTION" in
  s)
    tmux new-window -n "$(echo "$HOST_NAME" | cut -d. -f1)" \
      "ssh -t kero 'sudo ssh $HOST_NAME'" \; \
      pipe-pane "cat >> $LOG_FILE"
    ;;
  k|c|o)
    tmux new-window -n "$HOST_NAME" "ssh $HOST_NAME" \; \
      pipe-pane "cat >> $LOG_FILE"
    ;;
  h|v)
    tmux split-window "-$ACTION" "ssh -t kero 'sudo ssh $HOST_NAME'" \; \
      pipe-pane "cat >> $LOG_FILE"
    ;;
  *)
    echo_err
    ;;
esac
