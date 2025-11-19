// Silence Sass legacy JS API deprecation warnings until gulp-dart-sass migrates.
process.env.SASS_SILENCE_DEPRECATIONS = 'legacy-js-api';

const gulp = require('gulp');
const plumber = require('gulp-plumber');
const sourcemaps = require('gulp-sourcemaps');
const gulpSass = require('gulp-dart-sass');
const postcss = require('gulp-postcss');
const autoprefixer = require('autoprefixer');
const cssnano = require('cssnano');

const sassOptions = {
  silenceDeprecations: ['legacy-js-api']
};

// Compile global SCSS from scss/ into css/
const sassTask = () => {
  return gulp.src('scss/**/*.scss')
    .pipe(plumber())
    .pipe(sourcemaps.init())
    .pipe(gulpSass({
      // Search SCSS in theme, and BaseKit installed under contrib or custom.
      includePaths: [
        'scss',
        '../../contrib',
        '../../contrib/basekit',
        '../../contrib/basekit/scss',
        '../../contrib/basekit/components',
        '../../custom',
        '../../custom/basekit',
        '../../custom/basekit/scss',
        '../../custom/basekit/components'
      ],
      silenceDeprecations: ['legacy-js-api']
    }).on('error', gulpSass.logError))
    .pipe(postcss([autoprefixer(), cssnano()]))
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('css'));
};

// Compile component SCSS into the same folder as its source
const componentSassTask = () => {
  return gulp.src('components/**/*.scss', { base: 'components' })
    .pipe(plumber())
    .pipe(sourcemaps.init())
    .pipe(gulpSass({
      includePaths: [
        'scss',
        '../../contrib',
        '../../contrib/basekit',
        '../../contrib/basekit/scss',
        '../../contrib/basekit/components',
        '../../custom',
        '../../custom/basekit',
        '../../custom/basekit/scss',
        '../../custom/basekit/components'
      ],
      silenceDeprecations: ['legacy-js-api']
    }).on('error', gulpSass.logError))
    .pipe(postcss([autoprefixer(), cssnano()]))
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('components'));
};

// Watch both SCSS sources
const watchTask = () => {
  // Watch subtheme SCSS
  gulp.watch('scss/**/*.scss', sassTask);
  gulp.watch('components/**/*.scss', componentSassTask);
  // Also watch BaseKit sources (contrib or custom install paths) so imports trigger rebuilds.
  gulp.watch('../../contrib/basekit/scss/**/*.scss', sassTask);
  gulp.watch('../../contrib/basekit/components/**/*.scss', componentSassTask);
  gulp.watch('../../custom/basekit/scss/**/*.scss', sassTask);
  gulp.watch('../../custom/basekit/components/**/*.scss', componentSassTask);
};

// Default build compiles both
gulp.task('default', gulp.series(sassTask, componentSassTask));
// Alias compile -> default for convenience (npm run build passes args to gulp)
gulp.task('compile', gulp.series(sassTask, componentSassTask));
gulp.task('watch', watchTask);
