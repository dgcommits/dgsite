## Responsive Media setup

Responsivve media styles rely on these Drupal modules:

- Media (core)
- Responsive Image
- Breakpoint
- CKeditor
- Texst Editor

Responsive Media styles are identified first, by the area the design element is to be placed. For example, in a typical web template, content is viewd in an area with a consistent view area, such as #content would be conisitent thourght pages of a particular content type. Of cource, these standard-width view areas are most likely used between content types. why we start with the abstract area called, "main". Since "main" will have a defined area width in any of our breakpoints, we start with this for our machine name convention:

main_100_16x9 - applies to the "main" region, 100% width, 16x9 is the acpect ratio when the image is cropped

main_50_1x1 - applies to the "main" region, 50% width, 1x1 is the aspect ratio when the image is cropped

main_100 - applies to the "main" region, 100% width, no cropping

Templates + SCSS

- **web/themes/custom/gravelle1/templates/media/media--image.html.twig**

  Adds display--<view_mode> and media-ext--<ext> class to media wrappers.

```twig
{% set classes = [
  'media',
  'media-type--' ~ content.field_media_image['#field_type']|default('unknown'),
  'display--' ~ content.field_media_image['#view_mode']|default('unknown'),
  'media-ext--' ~ file_extension|default('unknown'),
] %}

<div{{ attributes.addClass(classes) }}>
  {{ title_suffix.contextual_links }}
  {{ content }}
</div>
```

- **web/themes/custom/gravelle1/scss/base/var/\_body-style.scss**

  CKEditor content widths for .media[class^="display--main_*"] and figure[data-view-mode^="main_*"].\*\*

```scss
.ck.ck-content {
  & > h2:first-child {
    /* when the first child of the ckeditor is an h2, remove top margin*/
    // margin-top: 0 !important;
  }

  /* load all body-styles from include file */
  @include bodyStyle;

  /* these styles are for elements viewed while editing in ckeditor, needed to mimic the final output */
  .drupal-media-style-align-left, /* applies to media */
  .image-style-align-left {
    /* applies to to inline images */
    margin: 0 2em 1em 0;
    max-width: 65%;
  }

  .drupal-media-style-align-right, /* applies to media */
  .image-style-align-right {
    /* applies to to inline images */
    margin: 0 0 1em 2em;
    max-width: 65%;
  }

  .drupal-media-style-align-center, /* applies to media */
  .image-style-align-center {
    /* applies to to inline images */
    text-align: center;
    margin: 0 auto 1em auto;
    max-width: 95%;
  }

  li img,
  p img {
    /* display inline images within text */
    vertical-align: middle;
    border: none;
    margin: 0 0.5em;
  }

  .media[class^='display--main_66'],
  figure[data-view-mode^='main_66'] {
    width: 65%;
    max-width: 65%;
  }

  .media[class^='display--main_50'],
  figure[data-view-mode^='main_50'] {
    width: 49%;
    max-width: 49%;
  }

  .media[class^='display--main_33'],
  figure[data-view-mode^='main_33'] {
    max-width: 32%;
  }

  .media[class^='display--main_25'],
  figure[data-view-mode^='main_25'] {
    max-width: 24%;
  }
  /* /ck_content */
}
```

- **web/themes/custom/gravelle1/scss/base/var/\_body-style.scss**
  @mixin bodyStyles includes all display sizing; see display--main\*_ and data-view-mode_=" main\*\*". applies @include bodyStyles; to .body-style content.

```scss
@mixin bodyStyle {
  /* these styles are imported into _body-style.scss and editor-styles.scss */
  /* include all styles that can apply to the editor body and the editor    */
  /* below, to style only the editor, use _editor-styles.scss after         */
  /* @import "custom-overwrites/globals/_body-style-include"                */

  /* position all block level element spacing from the bottom */
  h2,
  h3,
  h4,
  h5,
  h6,
  p,
  blockquote,
  figure,
  ul,
  ol,
  li {
    margin-top: 0;
  }

  /* h1 is outside the page-body in block layout */
  /* body-style headings are also used in modular sections */
  /* difinitions are found in globals/_mixins partial      */
  h2 {
    @include body-h2;
  }

  h3 {
    @include body-h3;
  }

  h4 {
    @include body-h4;
  }

  h5 {
    @include body-h5;
  }

  h6 {
    @include body-h6;
  }

  /* block-level elements */
  p,
  blockquote,
  figure,
  ul,
  ol {
    margin-bottom: 2em;
    font-family: vars.$font-body;
    line-height: vars.$line-height-body;
    font-size: vars.$font-size-body;
    /* max-width: 40rem; use max-width to improve line-length/readability sitewide */
  }

  ul,
  ol {
    /* remove margin-bottom from nested lists */
    ul,
    ol {
      margin-bottom: 0;
    }
  }

  ul,
  ol {
    list-style-position: outside;
    margin-left: 0;
    padding-left: 1.5em;
    overflow: hidden; /* prevent lists from extending into floats */
    li {
      padding-left: 0.5em;
      margin-bottom: units(2px);
    }
    li:last-child {
      margin-bottom: units(0);
    }
  }

  ul {
    ul {
      list-style-type: circle;
      ul {
        list-style-type: square;
        ul {
          list-style-type: circle;
        }
      }
    }
  }

  li,
  p {
    img {
      /* display inline images within text */
      vertical-align: middle;
      border: none;
      margin: 0 0.5em;
    }
  }

  /* images with captions are wrapped in figure tags */

  figure {
    margin: 0;
    margin-bottom: units(1);
    width: 100%;
    @include desktop-small {
      figure[class^='display--main_66'] {
        max-width: 65%;
      }
      figure[class^='display--main_50'] {
        max-width: 49%;
      }
      figure[class^='display--main_33'] {
        max-width: 32%;
      }
      figure[class^='display--main_25'] {
        max-width: 24%;
      }
    }
    p {
      display: inline; /* remove spacing from paragraph tags in media items */
      margin-bottom: 0;
    }
    div {
      display: inline;
    }
    img {
      padding: 0;
      margin: 0; /* remove margin from img in figure tag */
      display: block;
      @include desktop-small {
        border-bottom: 0;
      }
      &.align-center img {
        margin: 0 auto; /* use margin to center img in figure tag */
      }
    }
  }

  figcaption {
    color: vars.$gray;
    outline-offset: -1px;
    background-color: unset;
    margin: 0 !important;
    padding: 2em 0 0 0 !important;
    font-size: 0.75em;
    font-style: italic;
  }

  /* alignment for figures */

  figure .media {
    /* when media is inside a figure, remove margins, don't align and fill width */
    float: none;
    width: 100%;
    max-width: 100%;
    margin: 0 !important;
    img {
      display: block;
      width: 100%;
    }
  }

  .align-right,
  .align-left,
  .align-center {
    float: none; /* do not float on mobile */
    margin-bottom: 1em;
    p {
      /* render p as inline */
      display: inline;
    }
  }

  .align-right {
    @include desktop-small {
      float: right;
      margin-left: 2em;
      max-width: 65%;
      img.inline-img {
        width: 100% !important; /* make aligned image fit figure */
      }
    }
  }

  .align-left {
    @include desktop-small {
      float: left;
      margin: 0 2em 0 0;
      max-width: 65%;
      img.inline-img {
        width: 100% !important; /* make aligned image fit figure */
      }
    }
  }

  .align-center {
    text-align: center;
    margin: 0 auto units(1) auto;
    @include desktop-small {
      margin: 0 auto;
      max-width: 95%;
    }
  }
  @include desktop-small {
    figure:has([class*=' display--main_100']) {
      max-width: 100%;
    }

    figure:has([class*=' display--main_66']) {
      max-width: 65%;
    }

    figure:has([class*=' display--main_50']) {
      max-width: 49%;
    }

    figure:has([class*=' display--main_33']) {
      max-width: 32%;
    }

    figure:has([class*=' display--main_25']) {
      max-width: 24%;
    }
  }

  span.highlight {
    background-color: yellow;
    display: inline-block;
  }

  @include desktop-small {
    [class*=' display--main_66'],
    [data-view-mode*=' main_66'] {
      max-width: 65%;
    }
    [class*=' display--main_50'],
    [data-view-mode*=' main_50'] {
      max-width: 49%;
    }
    [class*=' display--main_33'],
    [data-view-mode*=' main_33'] {
      max-width: 32%;
    }
    [class*=' display--main_25'],
    [data-view-mode*=' main_25'] {
      max-width: 24%;
    }
  }

  /* force svg images and containers to fill display width */
  .media-ext--svg {
    width: 100%; /* on handheld svg media is 100% width */
    img {
      width: 100%;
    }
  }

  @include desktop-small {
    .media-ext--svg {
      &[class*='display--main_100'] {
        width: 100%;
      }
      &[class*='display--main_66'] {
        width: 65%;
      }
      &[class*='display--main_50'] {
        width: 49%;
      }
      &[class*='display--main_33'] {
        width: 32%;
      }
      &[class*='display--main_25'] {
        width: 24%;
      }
      img {
        width: 100%;
      }
    }
  }

  blockquote {
    margin: 0 1em 2em 0;
    padding: 2em 6em 2em 3em;
    border-left: 6px solid #ccc !important;

    &::before {
      display: none; /* hide gin border */
    }
    p {
      margin-top: 0;
      font-weight: vars.$font-weight-body-light;
      font-style: italic;

      &:last-child {
        margin-bottom: 0;
      }
      strong {
        font-weight: vars.$font-weight-body-medium; /* 500 */
      }
    }
  }

  .ck-horizontal-line hr,
  hr {
    background-color: 2px solid vars.$gray;
    height: 0px;
    border-top: 2px solid vars.$gray;
    clear: both;
  }
  a {
    &.button--red {
      background-color: #d83933;
      color: #fff;
      &:hover {
        background-color: #b50909;
      }
      &:active {
        background-color: #8b0a03;
      }
    }
    &.button--orange {
      color: #1b1b1b;
      background-color: #fa9441;
      &:hover {
        color: #fff;
        background-color: #c05600;
      }
      &:active {
        color: #fff;
        background-color: #775540;
      }
    }
  }

  table {
    border: 1px double #b3b3b3;
    border-collapse: collapse;
    border-spacing: 0;
    height: 100%;
    width: 100%;
    margin-bottom: 3em;
    th,
    td {
      border: 1px double #b3b3b3;
      padding: 0.4em;
      min-width: 2em;
    }
    th {
      background-color: rgba(0, 0, 0, 0.05);
      font-weight: 700;
    }
    td {
      border: 1px double #b3b3b3;
      padding: 0.25em;
    }
  }

  /* /bodyStyle */
}
```

web/themes/custom/busops/busops.info.yml:41 — registers CKEditor 5 stylesheet assets/css/editor-styles.css.

web/themes/custom/busops/assets/css/editor-styles.css:1 — compiled CSS that styles .ck.ck-content with display--main\_\* (built from the SCSS above).
