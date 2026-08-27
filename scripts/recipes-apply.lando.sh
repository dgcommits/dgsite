#!/usr/bin/env bash
set -euo pipefail

# Re-apply the aggregate recipe inside Lando, then rebuild cache.
# If Drupal's recipe command hits existing-config conflicts on an installed site,
# fall back to deterministic partial imports in dependency order.
# Usage: lando recipes-apply [/app/recipes/basekit-recipe/recipes/site]

RECIPE_PATH="${1:-/app/recipes/basekit-recipe/recipes/site}"

run_recipe() {
  if [ -d "/app/web" ]; then
    (cd /app/web && php core/scripts/drupal recipe "$RECIPE_PATH")
  else
    php /app/web/core/scripts/drupal recipe "$RECIPE_PATH"
  fi
}

partial_import_fallback() {
  echo "Recipe command failed; falling back to ordered partial config imports."

  drush en -y \
    block block_content field text image media media_library responsive_image views editor ckeditor5 rest workflows \
    node taxonomy layout_builder focal_point image_effects inline_svg crop paragraphs entity_reference_revisions \
    layout_builder_styles layout_builder_modal easy_breadcrumb bg_image_formatter responsive_bg_image_formatter \
    eva profile token superfish svg_image swiper_formatter admin_toolbar admin_toolbar_tools prism webform \
    environment_indicator menu_block twig_tweak config_split simple_sitemap

  local sources=(
    /app/recipes/basekit-recipe/recipes/basekit/config
    /app/recipes/basekit-recipe/recipes/paragraphs_base/config
    /app/recipes/basekit-recipe/recipes/blocks_hero_headline/config
    /app/recipes/basekit-recipe/recipes/blocks_hero_announcement/config
    /app/recipes/basekit-recipe/recipes/blocks_common/config
    /app/recipes/basekit-recipe/recipes/pages/config
    /app/recipes/basekit-recipe/recipes/article/config
    /app/recipes/basekit-recipe/recipes/profile_author/config
  )

  for source in "${sources[@]}"; do
    if [ -d "$source" ]; then
      drush cim -y --partial --source="$source"
    fi
  done
}

if run_recipe; then
  echo "Recipe applied."
else
  partial_import_fallback
fi

drush cset system.theme default basekit_site -y
drush cset system.theme admin basekit_site -y
drush updb -y
drush cr

echo "Recipe applied and config imported."
