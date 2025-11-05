# Custom blocks

Custom block on this site are design for usage. For example, a "banner" will fill the full wiwth of the contenet where a "grid" will display a set of content items.

Custom blocks ar stored as Drupal SDCs so files are consolidated. Where there are

Custom blocks allow fro multiple "view-modes" to suit user preferences. View mode machine names are ordered 00-99 to keep naming concsisitent, but lables can be used on the frontend to helpo content editor dirrentiate their use.

Custom block view modes are are set up in the SDC in the partials folder (which cold be changed to "displays" or "view-modes")

### Example Custom Block folder setup

Block templates delegate the blocks and view-mode rendering to the SDC:

```
templates/block/block--block-content--type--banner-announcement.html.twig
```

```
banner_announcement/
├─ partials/
│ ├─ banner_announcement_01.html.twig
│ ├─ banner_announcement_02.html.twig
│ └─ default.html.twig
├─ banner_announcement.component.yml
├─ banner_announcement.css
├─ banner_announcement.css.map
├─ banner_announcement.html.twig
├─ banner_announcement.scss
└─ banner_announcement.twig
```

CSS is imported into the them from the library file:

```
# SDC component library: Banner Announcement
banner_announcement:
  css:
    theme:
      components/banner_announcement/banner_announcement.css: {}
```
