#!/usr/bin/env bash
# inception deploy bot: on boot, authenticates and publishes stack status
set -e
DEPLOY_PAT=$(cat /run/secrets/deploy_pat)
gh auth login --with-token <<< "$DEPLOY_PAT"
while true; do
  gh api user >/dev/null 2>&1 && echo "[deploybot] heartbeat ok"
  sleep 3600
done
