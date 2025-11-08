# Custom Blocks (SDC standard)

This site’s custom blocks are implemented as Single‑Directory Components (SDCs) so each block’s template, variants, and styles live together and are easy to maintain.

Key ideas

- Keep block bundles stable and intentional (hero*\*, grid*_, media*text, quote*_, text_rich).
- Use view modes only for structural/formatter differences (different fields/order/formatters).
- Use SDC props for styling/behavior (clickable, density, theme, media style).
- blocks can reuse field machine names like, block_text, block_image, block_link, etc.

When to add a view mode vs. a prop

- View mode: you must change field composition or formatters (e.g., split_left vs split_right layouts).
- Prop: same fields, different behavior or style (e.g., make the whole block clickable, compact spacing).

Standard SDC layout (per bundle)

Block template delegates all rendering to the SDC based on the current view mode:

```
templates/block/block--block-content--type--<bundle>.html.twig
```

Component folder and files:

```
components/<bundle>/
├─ partials/
│ ├─ <view_mode>.html.twig
│ └─ default.html.twig
├─ <bundle>.component.yml
├─ <bundle>.twig (or .html.twig)
├─ <bundle>.scss → compiled to <bundle>.css (+ .map)
```

Component library is attached by the component and declared in the theme:

```
# SDC component library example
<bundle>:
  css:
    theme:
      components/<bundle>/<bundle>.css: {}
```

Current bundles and variants (target naming)

- hero_announcement (was banner_announcement)
  - View modes: default, variant_01 (only if structurally different)
  - Props: clickable (bool), density: default|compact, theme: light|dark
- hero_headline (was banner_headline)
  - View modes: default, compact (only if formatter/visibility differ)
  - Props: density, theme
- hero_media (was banner_media)
  - View modes: split_left, split_right (stacked only if structural)
  - Props: density, theme, media_format (e.g., wide|square)
- quote_feature (was banner_quotes)
  - View modes: default
  - Props: slider: none|carousel, autoplay (bool), density, theme
- grid_topics (kept)
  - View modes: default (cards VM only if item formatter/fields differ)
  - Props: columns: 2|3|4, density, clickable, theme
  - Items: Uses Paragraphs (type: `topic_item`) for the grid cards. Fields per item: `field_block_image` (image), `field_block_title` (text), `field_block_text` (text, optional), `field_block_link` (link with title). The block bundle holds an items field `field_block_items` (Entity Reference Revisions) allowing multiple `topic_item` entries.
- media_text (was grid_text_image_pair)
  - View modes: split_left, split_right (stacked only if structural)
  - Props: density, theme
- text_rich (was custom_text)
  - View modes: default
  - Props: density, theme, clickable
