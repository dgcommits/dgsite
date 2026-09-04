// Silence Sass legacy JS API deprecation warnings until gulp-dart-sass migrates.
process.env.SASS_SILENCE_DEPRECATIONS = 'legacy-js-api';

const path = require('path');
const fs = require('fs');
const gulp = require('gulp');
const plumber = require('gulp-plumber');
const sourcemaps = require('gulp-sourcemaps');
const gulpSass = require('gulp-dart-sass');
const postcss = require('gulp-postcss');
const autoprefixer = require('autoprefixer');
const cssnano = require('cssnano');

const isProd = process.env.NODE_ENV === 'production';

// Compile global SCSS from scss/ into css/
const includePaths = [
  'scss',
  path.resolve(__dirname, '../../contrib/basekit/scss'),
  path.resolve(__dirname, '../../contrib/basekit/components')
];

const sassTask = () => {
  let stream = gulp.src('scss/**/*.scss')
    .pipe(plumber());

  if (!isProd) {
    stream = stream.pipe(sourcemaps.init());
  }

  stream = stream
    .pipe(gulpSass({
      includePaths,
      silenceDeprecations: ['legacy-js-api']
    }).on('error', gulpSass.logError))
    .pipe(postcss([autoprefixer(), cssnano()]));

  if (!isProd) {
    stream = stream.pipe(sourcemaps.write('.'));
  }

  return stream.pipe(gulp.dest('css'));
};

// Compile component SCSS into the same folder as its source
const componentSassTask = () => {
  if (!fs.existsSync(path.resolve(__dirname, 'components'))) {
    return Promise.resolve();
  }

  let stream = gulp.src('components/**/*.scss', {
    allowEmpty: true,
    base: 'components'
  })
    .pipe(plumber());

  if (!isProd) {
    stream = stream.pipe(sourcemaps.init());
  }

  stream = stream
    .pipe(gulpSass({
      includePaths,
      silenceDeprecations: ['legacy-js-api']
    }).on('error', gulpSass.logError))
    .pipe(postcss([autoprefixer(), cssnano()]));

  if (!isProd) {
    stream = stream.pipe(sourcemaps.write('.'));
  }

  return stream.pipe(gulp.dest('components'));
};

// Watch both SCSS sources
const watchTask = () => {
  gulp.watch('scss/**/*.scss', sassTask);
  gulp.watch('components/**/*.scss', componentSassTask);
};

// Default build compiles both
gulp.task('default', gulp.series(sassTask, componentSassTask));
gulp.task('watch', watchTask);
