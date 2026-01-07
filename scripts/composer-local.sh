#!/usr/bin/env bash
#
# Wrapper to use composer.json as the root package so the merge plugin
# can include composer.local.json for local path repos.

set -euo pipefail

export COMPOSER="${COMPOSER_OVERRIDE:-composer.json}"

exec composer "$@"
