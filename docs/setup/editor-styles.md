# Editor Styles (WYSIWYG)

In order to create a unified set of styles that works in all long text field elements. There is a bodyStyle mixin, that imports the css for prose. It uses default variables for headings as well ensureing that not just the ckeditor, but all formatted content follows the same rules.

To apply styles to all long-text fields, change the templates to make sure the body-style class is applied globally.

- templates/field/field--text-with-summary.html.twig
- templates/field/field--text-long.html.twig

The body-style class imports the bodyStyle mixin so that the set of styles for prose can be used anywhere.

The headings and body-copy elements can be customized by editing the default variables in scss/base/var/\_var_default.scss

- **web/themes/custom/gravelle1/scss/base/var/\_body-style.scss**

  Applies @include bodyStyle; to .body-style content.

  ```scss
  .body-style {
    @include bodyStyles;
  }
  ```

- **web/themes/custom/gravelle1/scss/base/var/\_mixins.scss**

  Includes base heading styles to later be imported into bodyStyle mixin for .body-style class. ELemts can aplso be applic independently outsite the editor/body region with:

  ```scss
  h2 {
    @include body-h2;
  }
  ```

  ```scss
  @mixin body-h2 {
    font-size: $font-size-h2;
    margin-top: 0;
    margin-bottom: 3em;
    padding-bottom: 0.5em;
    letter-spacing: -0.03em;
    font-family: $font-heading;
    color: $color-h2;
    font-weight: $font-weight-h2;
    &:after {
      margin-top: 0.4em;
      border-bottom: 2px solid $color-h2;
      display: flex; /* prevent border-bottom from overlapping floats */
      content: '';
    }
  }

  @mixin body-h3 {
    font-size: $font-size-h3;
    letter-spacing: -0.03em;
    font-family: $font-heading;
    margin-top: 0;
    margin-bottom: 2em;
    color: $color-h3;
    font-weight: $font-weight-h3;
  }

  @mixin body-h4 {
    font-size: $font-size-h4;
    letter-spacing: -0.03em;
    margin-top: 0;
    margin-bottom: 2em;
    font-weight: $font-wight-h2;
  }

  @mixin body-h5 {
    font-size: $font-size-h5;
    margin-top: 0;
    margin-bottom: 1em;
    color: $gray;
  }

  @mixin body-h6 {
    font-size: $font-size-h6;
    margin-top: 0;
    margin-bottom: 0.5em;
  }
  ```

- **web/themes/custom/gravelle1/scss/base/var/\_body-style.scss**

  includes all formatting styles where the .body-styles class is applied. aspects that apply specifically to media and responsive media are also included.

  ```scss
  @mixin bodyStyles {
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
      margin-bottom: units(2);
      font-family: family($theme-prose-font-family);
      line-height: line-height('body', $theme-body-line-height);
      font-size: size(body, 5);
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
        margin: 0 units(0.5);
      }
    }

    /* images with captions are wrapped in figure tags */

    figure {
      margin: 0;
      margin-bottom: units(1);
      width: 100%;
      @include at-media('tablet') {
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
        @include at-media('tablet') {
          border-bottom: 0;
        }
        &.align-center img {
          margin: 0 auto; /* use margin to center img in figure tag */
        }
      }
    }

    figcaption {
      color: color('gray-50');
      outline-offset: -1px;
      background-color: unset;
      margin: 0 !important;
      padding: units(2px) 0 0 0 !important;
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
      margin-bottom: units(1);
      p {
        /* render p as inline */
        display: inline;
      }
    }

    .align-right {
      @include at-media('tablet') {
        float: right;
        margin-left: units(2);
        max-width: 65%;
        img.inline-img {
          width: 100% !important; /* make aligned image fit figure */
        }
      }
    }

    .align-left {
      @include at-media('tablet') {
        float: left;
        margin: 0 units(2) 0 0;
        max-width: 65%;
        img.inline-img {
          width: 100% !important; /* make aligned image fit figure */
        }
      }
    }

    .align-center {
      text-align: center;
      margin: 0 auto units(1) auto;
      @include at-media('tablet') {
        margin: 0 auto;
        max-width: 95%;
      }
    }
    @include at-media('tablet') {
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

    @include at-media('tablet') {
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

    @include at-media('tablet') {
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
      margin: units(0) units(1) units(2) units(0);
      padding: units(2) units(6) units(2) units(3);
      border-left: 6px solid #ccc !important;

      &::before {
        display: none; /* hide gin border */
      }
      p {
        margin-top: 0;
        font-weight: $theme-font-weight-light;
        font-style: italic;

        &:last-child {
          margin-bottom: 0;
        }
        strong {
          font-weight: $theme-font-weight-medium; /* 500 */
        }
      }
    }

    .ck-horizontal-line hr,
    hr {
      background-color: 2px solid color('gray-cool-10');
      height: 0px;
      border-top: 2px solid color('gray-cool-10');
      clear: both;
    }
    a {
      &.usa-button--red {
        background-color: #d83933;
        color: #fff;
        &:hover {
          background-color: #b50909;
        }
        &:active {
          background-color: #8b0a03;
        }
      }
      &.usa-button--orange {
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
      margin-bottom: units(3);
      th,
      td {
        border: 1px double #b3b3b3;
        padding: 0.4rem;
        min-width: 2rem;
      }
      th {
        background-color: rgba(0, 0, 0, 0.05);
        font-weight: 700;
      }
      td {
        border: 1px double #b3b3b3;
        padding: 0.25rem;
      }
    }
    /* /bodyStyles */
  }
  ```
