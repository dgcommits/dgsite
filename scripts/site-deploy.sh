#!/usr/bin/env bash
#
# Usage:
#   scripts/site-deploy.sh <site-key>
#
# Logs into the remote server defined in sites.ini, pulls the latest code,
# installs composer deps, updates BaseKit packages, and runs Drush updates.

set -euo pipefail

RED=$'\033[1;31m'
GREEN=$'\033[1;32m'
NC=$'\033[0m'

SITE_KEY="${1:-}"

if [ -z "$SITE_KEY" ]; then
  echo "Usage: site-deploy.sh <site-key>" >&2
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

eval "$("$ROOT_DIR/scripts/site-env.sh" "$SITE_KEY")"

if [ -z "${PROD_SSH:-}" ] || [ -z "${PROD_WEBROOT:-}" ]; then
  echo "${RED}Missing PROD_SSH or PROD_WEBROOT for ${SITE_KEY} in sites.ini${NC}" >&2
  exit 1
fi

echo "${GREEN}Deploying updates to ${SITE_KEY} on ${PROD_SSH}...${NC}"

APP_ROOT="${PROD_APP_ROOT:-}"
WEB_ROOT="${PROD_WEBROOT}"
if [ -z "$APP_ROOT" ]; then
  APP_ROOT="$(dirname "$WEB_ROOT")"
fi

ssh -T "$PROD_SSH" <<EOF
set -euo pipefail
if [ -f ~/.bash_profile ]; then
  # shellcheck source=/dev/null
  . ~/.bash_profile
  echo "loaded .bash_profile"
fi
cd "$APP_ROOT"
echo "→ Pull latest git changes"
git pull
echo "→ Install composer dependencies"
composer install --no-dev --optimize-autoloader
echo "→ Update BaseKit packages"
composer update gravellian/basekit gravellian/basekit-recipe gravellian/basekit-docs --with-all-dependencies --no-dev --optimize-autoloader
echo "→ Run Drush updates"
"\$APP_ROOT/vendor/bin/drush" --root="$WEB_ROOT" updb -y
"\$APP_ROOT/vendor/bin/drush" --root="$WEB_ROOT" cr
EOF

echo "${GREEN}✔ Deployment complete.${NC}"
