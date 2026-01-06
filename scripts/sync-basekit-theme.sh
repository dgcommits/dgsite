#!/usr/bin/env bash
set -euo pipefail

# Syncs the editable basekit repo into a BaseKit site so the running theme matches
# the source tree you edit.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SITE_KEY="${1:-}"

if [[ -z "$SITE_KEY" ]]; then
  echo "Usage: $(basename "$0") <site-key>" >&2
  exit 1
fi

eval "$("$REPO_ROOT/../scripts/site-env.sh" "$SITE_KEY")"

if [[ -d "$REPO_ROOT/web" && "$(basename "$REPO_ROOT")" == "$DEV_PATH" ]]; then
  SITE_ROOT="$REPO_ROOT"
else
  SITE_ROOT="${REPO_ROOT}/${DEV_PATH}"
fi
BASEKIT_SRC="$(cd "$REPO_ROOT/../basekit" && pwd)"
BASEKIT_DEST="${SITE_ROOT}/web/themes/contrib/${basekit_theme:-basekit}"

if [[ ! -d "$BASEKIT_SRC" ]]; then
  echo "BaseKit source not found at $BASEKIT_SRC" >&2
  exit 1
fi

mkdir -p "${BASEKIT_DEST}"

echo "Syncing BaseKit sources into ${BASEKIT_DEST} ..."
rsync -a --delete "$BASEKIT_SRC/" "$BASEKIT_DEST/"

echo "Sync complete. Run 'lando drush cr' inside ${SITE_KEY} if needed."
