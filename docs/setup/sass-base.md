# Sass Base Module

Int his site we use a base sass module (modern dart sass). to include all the theme.

gravelle1/scss/base

the base module can be included in any file by using this statement at the top:
`@use '../base' as *;`

```
base/ - includes all theme variables, mixins, encoded svgs
├─ var/
│  ├─ _body-style.scss - body-style/prose definitions
│  ├─ _icons.scss - encoded svgs as sass variables
│  ├─ _index.scss - module entrypoint
│  ├─ _load-effects.scss - load effects
│  ├─ _mixins.scss - descriptions here
│  └─ _var_default.scss - site vatiables
└─ _index.scss

```
