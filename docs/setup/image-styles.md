# Image Styles

**handheld:** mediaQuery: 'all and (max-width: 767px) and (min-width: 1px)'

**desktop-small:**
mediaQuery: 'all and (max-width: 1023px) and (min-width: 768px)'

**desktop-medium**
mediaQuery: 'all and (max-width: 1364px) and (min-width: 1024px)'

**desktop-large:**
mediaQuery: 'all and (max-width: 1919px) and (min-width: 1365px)'

**desktop-max:**
mediaQuery: 'all and (min-width: 1920px)'

**"main" viewports by breakpoint**

- handheld: 705px
- small: 635px
- medium: 846px
- large: 1128
- max: 1587px

## responsive-image-styles

- responsive_image.styles.main_100.yml
  - image.style.main_100_handheld.yml (705)
  - image.style.main_100_small.yml (635)
  - image.style.main_100_med.yml (846)
  - image.style.main_100_large.yml (1128)
  - image.style.main_100_max.yml (1587)

- responsive_image.styles.main_100_4x3.yml
  - image.style.main_100_4x3_handheld.yml (705 x 529)
  - image.style.main_100_4x3_small.yml (635 x 476)
  - image.style.main_100_4x3_med.yml (846 x 635)
  - image.style.main_100_4x3_large.yml (1128 x 846)
  - image.style.main_100_4x3_max.yml (1587 x 1190)

- responsive_image.styles.main_100_16x9.yml
  - image.style.main_100_16x9_handheld.yml (705 x 396)
  - image.style.main_100_16x9_small.yml (635 x 357)
  - image.style.main_100_16x9_med.yml (846 x 475)
  - image.style.main_100_16x9_large.yml (1128 x 635)
  - image.style.main_100_16x9_max.yml (1587 x 893)

- responsive_image.styles.main_100_21x9.yml
  - ~~image.style.main_100_21x9_handheld.yml~~ -- use image.style.main_100_1x1_handheld.yml
  - ~~image.style.main_100_21x9_small.yml~~ -- use image.style.main_100_4x3_small.yml
  - image.style.main_100_21x9_med.yml (846 x 363)
  - image.style.main_100_21x9_large.yml (1128 x 483)
  - image.style.main_100_21x9_max.yml (1587 x 680)

- responsive_image.styles.main_66.yml
  - ~~image.style.main_66_handheld.yml~~ -- use image.style.main_100_handheld.yml
  - image.style.main_66_small.yml (421)
  - image.style.main_66_med.yml (560)
  - image.style.main_66_large.yml (747)
  - image.style.main_66_max.yml (1048)

- responsive_image.styles.main_66_4x3.yml
  - ~~image.style.main_66_4x3_handheld.yml~~ -- use image.style.main_100_1x1_handheld.yml
  - image.style.main_66_4x3_small.yml (421 x 316)
  - image.style.main_66_4x3_med.yml (560 x 420)
  - image.style.main_66_4x3_large.yml (747 x 560)
  - image.style.main_66_4x3_max.yml (1048 x 786)

- responsive_image.styles.main_66_16x9.yml
  - ~~image.style.main_66_16x9_handheld.yml~~ -- use image.style.main_100_1x1_handheld.yml
  - image.style.main_66_16x9_small.yml (421 x 237)
  - image.style.main_66_16x9_med.yml (560 x 315)
  - image.style.main_66_16x9_large.yml (747 x 420)
  - image.style.main_66_16x9_max.yml (1048 x 590)

- responsive_image.styles.main_50.yml
  - ~~image.style.main_50_handheld.yml~~ (340) -- use image.style.main_100_handheld.yml
  - image.style.main_50_small.yml (312)
  - image.style.main_50_med.yml (416)
  - image.style.main_50_large.yml (555)
  - image.style.main_50_max.yml (780)

- responsive_image.styles.main_50_1x1.yml
  - ~~image.style.main_50_1x1_handheld.yml~~ -- use image.style.main_100_1x1_handheld.yml
  - image.style.main_50_1x1_small.yml (312 x 312)
  - image.style.main_50_1x1_med.yml (416 x 416)
  - image.style.main_50_1x1_large.yml (555 x 555)
  - image.style.main_50_1x1_max.yml (780 x 780)

- responsive_image.styles.main_50_4x3.yml
  - ~~image.style.main_50_4x3_handheld.yml~~ -- use image.style.main_100_4x3_handheld.yml
  - image.style.main_50_4x3_small.yml (312 x 234)
  - image.style.main_50_4x3_med.yml (416 x 312)
  - image.style.main_50_4x3_large.yml (555 x 416)
  - image.style.main_50_4x3_max.yml (780 x 585)

- responsive_image.styles.main_50_16x9.yml
  - ~~image.style.main_50_16x9_handheld.yml~~ -- use image.style.main_100_4x3_handheld.yml
  - image.style.main_50_16x9_small.yml (312 x 175)
  - image.style.main_50_16x9_med.yml (416 x 234)
  - image.style.main_50_16x9_large.yml (555 x 312)
  - image.style.main_50_16x9_max.yml (780 x 439)

- responsive_image.styles.main_33.yml
  - ~~image.style.main_33_handheld.yml~~ -- use image.style.main_100_handheld.yml
  - image.style.main_33_small.yml (205)
  - image.style.main_33_med.yml (273)
  - image.style.main_33_large.yml (364)
  - image.style.main_33_max.yml (511)

- responsive_image.styles.main_33_1x1.yml
  - ~~image.style.main_33_1x1_handheld.yml~~ -- use image.style.main_100_4x3_handheld.yml
  - image.style.main_33_1x1_small.yml (205 x 205)
  - image.style.main_33_1x1_med.yml (273 x 273)
  - image.style.main_33_1x1_large.yml (364 x 364)
  - image.style.main_33_1x1_max.yml (511 x 511)

- responsive_image.styles.main_33_4x3.yml
  - ~~image.style.main_33_4x3_handheld.yml~~ -- use image.style.main_100_4x3_handheld.yml
  - image.style.main_33_4x3_small.yml (205 x 154)
  - image.style.main_33_4x3_med.yml (273 x 205)
  - image.style.main_33_4x3_large.yml (364 x 273)
  - image.style.main_33_4x3_max.yml (511 x 383)

- responsive_image.styles.main_25.yml
  (when using 25% images, mobile viewport switches to 50% 2-column/4-column)
  - ~~image.style.main_25_handheld.yml~~ -- use image.style.main_50_handheld.yml
  - image.style.main_25_small.yml (118)
  - image.style.main_25_med.yml (157)
  - image.style.main_25_large.yml (210)
  - image.style.main_25_max.yml (296)

- responsive_image.styles.main_25_1x1.yml
  (when using 25% images, mobile viewport switches to 50% 2-column/4-column)
  - ~~image.style.main_25_1x1_handheld.yml~~ -- use image.style.main_50_1x1_handheld.yml
  - image.style.main_25_1x1_small.yml (118 x 118)
  - image.style.main_25_1x1_med.yml (157 x 157)
  - image.style.main_25_1x1_large.yml (210 x 210)
  - image.style.main_25_1x1_max.yml (296 x 296)
