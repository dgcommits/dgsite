This feature recipe installs the Article content model and roles.

Populate `config/` with these YAML files (copied from your `config/sync/`):

- node.type.article.yml
- field.storage.node.field_article_body.yml
- field.field.node.article.field_article_body.yml
- field.field.node.article.field_image.yml
- field.field.node.article.field_tags.yml
- core.entity_form_display.node.article.default.yml
- core.entity_view_display.node.article.default.yml
- core.entity_view_display.node.article.teaser.yml
- core.entity_view_display.node.article.rss.yml
- taxonomy.vocabulary.tags.yml
- filter.format.article.yml
- editor.editor.article.yml
- user.role.article_author.yml
- user.role.article_editor.yml
- optional: views.view.article_index.yml, views.view.manage_articles.yml

Apply:

  php core/scripts/drupal recipe recipes/article
  drush cim -y && drush cr

