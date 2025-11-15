Populate `config/` with YAML for the hero_headline block bundle, for example:

- block_content.type.hero_headline.yml
- field.storage.block_content.field_block_title.yml
- field.storage.block_content.field_block_text.yml
- field.storage.block_content.field_block_image.yml
- field.storage.block_content.field_block_icon.yml
- field.field.block_content.hero_headline.field_block_title.yml
- field.field.block_content.hero_headline.field_block_text.yml
- field.field.block_content.hero_headline.field_block_image.yml
- field.field.block_content.hero_headline.field_block_icon.yml
- core.entity_form_display.block_content.hero_headline.default.yml
- core.entity_view_display.block_content.hero_headline.default.yml
- optional variants:
  - core.entity_view_display.block_content.hero_headline.variant_01.yml
  - core.entity_view_display.block_content.hero_headline.variant_02.yml

Apply:

  php core/scripts/drupal recipe recipes/blocks/hero_headline
  drush cim -y && drush cr

