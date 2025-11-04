# Responsive Template

This site has a responsive template and breakpoints. Rather than changing the layout at each breakpoint, it's designed to be scalable with only two layouts, one for handheld screens, and one for desktops (starting with "desktop small").

The mobile layout scales text based on viewport width (vw), so the design stays fluid at screen sizes 767 pixels.

the desktop layout breakpoints (small - max) update the site page width and scales the text proprtianely at each breakpoint. The outcome is a consistent layout and text size proportinos at each desktop breakpoint. paragraph line length should be stable so the design is not shifting for different screensizes or devices.

scss/layout/\_page.scss

```scss
/* handheld */
@media all and (max-width: 767px) {
  html {
    font-size: 2.6vw;
  }

  .sitew {
    width: 100vw;
  }
  /* /handheld */
}

/* desktop - small - 768 - 1024 */
@media all and (max-width: 1023px) and (min-width: 768px) {
  html {
    font-size: 8.8px; /* 40% */
  }

  .sitew {
    width: 768px;
  }
  /* /small */
}

/* desktop - medium - 1024 - 1366 */
@media all and (max-width: 1364px) and (min-width: 1024px) {
  html {
    font-size: 11.733333333333333px; /* 53.333333333333336% */
  }

  .sitew {
    width: 1024px;
  }
  /* /medium */
}

/* desktop -large - 1366+ */
@media all and (max-width: 1919px) and (min-width: 1365px) {
  html {
    font-size: 15.640625px; /* 71.09375% */
  }

  .sitew {
    width: 1365px;
  }
  /* /large */
}

/* desktop - max - 1920+ */
@media all and (min-width: 1920px) {
  html {
    font-size: 22px; /* 100% - all media query body font-size math starts here */
  }

  .sitew {
    width: 1920px;
  }
  /* /max */
}
```
