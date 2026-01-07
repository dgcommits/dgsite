#!/usr/bin/env bash
#
# Usage (run from inside a site directory, e.g., dev.justsomeguypainting.com2):
#   ../scripts/site-task.sh db [--import]
#   ../scripts/site-task.sh files
#   ../scripts/site-task.sh update-basekit
#   ../scripts/site-task.sh env
#
# Auto-detects the site key from the current working directory name,
# loads its settings from sites.ini, and dispatches to the existing
# helper scripts in ../scripts/.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # /app/scripts
SITE_ROOT="$(cd "$ROOT_DIR/.." && pwd)"                 # /app/<site>
# Absolute path to shared scripts dir (one level above SITE_ROOT on host)
WORKSPACE_ROOT="$(cd "$SITE_ROOT/.." && pwd)"

if [ -f "$SITE_ROOT/.site-key" ]; then
  SITE_KEY="$(tr -d '\n' < "$SITE_ROOT/.site-key")"
elif [ -n "${LANDO_APP_NAME:-}" ]; then
  SITE_KEY="${LANDO_APP_NAME}"
else
  SITE_KEY="$(basename "$SITE_ROOT")"
fi

if [ "$#" -lt 1 ]; then
  echo "Usage: site-task.sh <db|files|update-basekit|env> [args]" >&2
  exit 1
fi

COMMAND="$1"
shift

echo "Site task:"
echo "  SITE_KEY     = $SITE_KEY"
echo "  SITE_ROOT    = $SITE_ROOT"
echo "  WORKSPACE_ROOT = $WORKSPACE_ROOT"
echo "  COMMAND      = $COMMAND $*"

case "$COMMAND" in
  getDb|db)
    "$WORKSPACE_ROOT/scripts/site-db.sh" "$SITE_KEY" "$@"
    ;;
  getFiles|files)
    "$WORKSPACE_ROOT/scripts/site-files.sh" "$SITE_KEY"
    ;;
  getBase|update-basekit)
    "$WORKSPACE_ROOT/scripts/site-update-basekit_host.sh" "$SITE_KEY"
    ;;
  deploy)
    "$WORKSPACE_ROOT/scripts/site-deploy.sh" "$SITE_KEY"
    ;;
  env)
    "$WORKSPACE_ROOT/scripts/site-env.sh" "$SITE_KEY"
    ;;
  *)
    echo "Unknown command: $COMMAND" >&2
    echo "Available commands: getDb, getFiles, getBase, deploy, env" >&2
    exit 1
    ;;
esac
