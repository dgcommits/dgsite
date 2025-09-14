# Repository Guidelines (Codex-aware)

This file tells Codex how to work in this repository: what commands to use,
where code lives, and what rules to follow.

---

## Project Structure & Module Organization

- Docroot: `web/` (Drupal 11).
- Custom theme: `web/themes/custom/gravelle1/`.
- Custom modules (if added): `web/modules/custom/`.
- Config sync: `config/sync/` (commit exported YAML changes).
- Composer deps: `vendor/`.
- Theme sources: `scss/`, `components//`.
- Compiled CSS: `css/`.

Codex may **create or edit**:

- SCSS in `scss/` or `components/.../*.scss`
- Twig templates and YAML in `components/.../`
- Custom PHP modules under `web/modules/custom/`
- Config YAML in `config/sync/` (when task is about config)

Codex must **not edit**:

- `vendor/`, `web/core/`, `node_modules/`, or built CSS/JS outside `css/`
- `.gitignore`, `.env`, or secrets without explicit instruction

---

## Build, Test, and Development Commands

Codex should prefer **Lando** if available (`lando <command>`).
If `lando` is missing, run the raw command.

### Environment

- Start: `lando start` (site at http://localhost:8080)

### Dependencies

- PHP deps: `lando composer install`
- Theme deps: `cd web/themes/custom/gravelle1 && lando npm install`

### Build

- One-off: `cd web/themes/custom/gravelle1 && lando gulp`
- Continuous: `cd web/themes/custom/gravelle1 && lando watch`

### Drupal tasks

- Rebuild cache: `lando drush cr`
- Config import/export:
  - Import: `lando drush cim -y`
  - Export: `lando drush cex -y`

### Database (optional)

- Restore: `lando db-import latest.sql.gz`

---

## Coding Style & Naming Conventions

- Indentation: 2 spaces (except 4 in `composer.json`/`.lock`)
- PHP: Drupal standards via PHP-CS-Fixer
  - Check: `vendor/bin/php-cs-fixer fix --dry-run -v`
  - Apply: `vendor/bin/php-cs-fixer fix`
- JS/SCSS: Prettier (`.prettierrc`), single quotes, 80 cols
  - Run Prettier before commit
- Theme SCSS: shared in `scss/`, per-component in `components/<component>/<name>.scss`
- Do not commit build artifacts outside `css/` and generated maps

---

## Testing Guidelines

- PHPUnit tests under `web/modules/custom/<module>/tests/src/{Unit,Kernel,Functional}`
- Run inside appserver:
  - `lando ssh -s appserver`
  - `vendor/bin/phpunit`
- Prefer Unit tests; Kernel/Functional only when needed

---

## Commit & Pull Request Guidelines

- Commits: imperative mood, concise scope prefix
  - Example: `theme: compile SCSS for header`
  - Example: `config: export block placements`
- PRs must include:
  - Summary + rationale
  - Testing steps
  - Screenshots (UI)
  - Config or build notes
  - Linked issue/ticket

Codex should suggest commit messages in this format:
`<scope>: <short action>` (e.g. `theme: refactor mobile nav`)

---

## Security & Configuration Tips

- Do not commit secrets.
- Use `settings.local.php` and env vars.
- Ignore: `vendor/`, `web/core/`, contrib themes/modules, `web/sites/*/files/`

---

## Codex Workflow

- Always show diffs before applying large changes.
- After changes:
  1. Run `lando gulp` to rebuild theme
  2. Run `vendor/bin/php-cs-fixer fix --dry-run -v` (PHP)
  3. Run Prettier if configured
  4. Run `lando drush cr` if config/PHP/Twig changed
- Summarize: which files were changed, commands run, and whether build/lint/tests passed.
