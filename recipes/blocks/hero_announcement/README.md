Populate `config/` with YAML for the hero_announcement block bundle, for example:

- block_content.type.hero_announcement.yml
- field.storage.block_content.field_block_title.yml
- field.storage.block_content.field_block_text.yml
- field.storage.block_content.field_block_image.yml
- field.storage.block_content.field_block_icon.yml
- field.storage.block_content.field_block_link.yml
- field.field.block_content.hero_announcement.field_block_title.yml
- field.field.block_content.hero_announcement.field_block_text.yml
- field.field.block_content.hero_announcement.field_block_image.yml
- field.field.block_content.hero_announcement.field_block_icon.yml
- field.field.block_content.hero_announcement.field_block_link.yml
- core.entity_form_display.block_content.hero_announcement.default.yml
- core.entity_view_display.block_content.hero_announcement.default.yml
- optional variants:
  - core.entity_view_display.block_content.hero_announcement.variant_01.yml

Apply:

  php core/scripts/drupal recipe recipes/blocks/hero_announcement
  drush cim -y && drush cr

