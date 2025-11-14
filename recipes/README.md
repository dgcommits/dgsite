Recipes structure

- recipes/basekit/ — default/base recipe (modules + shared config)
- recipes/article/ — feature recipe for the Article content model (node + roles)
- recipes/blocks/<bundle>/ — one recipe per custom block type (optional)
- recipes/site/ — aggregator that composes the above

Apply a recipe

- Local path: `php core/scripts/drupal recipe recipes/<name>`
- After applying: `drush cim -y && drush cr`

Re-apply to update

- Update config under the recipe’s `config/` folder, then run the same command again and import config.

