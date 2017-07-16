#Require gulp
gulp = require('gulp')

# Include Plugins
browserSync = require('browser-sync')
$ = require('gulp-load-plugins')()
fontAwesome = require('node-font-awesome');

# Task SASS + autoprefixer + CSScomb + browserSync
gulp.task 'sass', ->
  gulp.src 'scss/*scss'
    .pipe $.sass()
    #onError: console.error.bind(console, 'SASS Error:')
    .pipe $.csscomb()
    .pipe $.autoprefixer
      browsers:["ie >= 11","Firefox >= 20","Chrome >= 20","Edge >= 20","Safari >= 20", "Firefox ESR"]
    .pipe gulp.dest 'assets/css/'
    #.pipe browserSync.reload(stream:true)


# Task fontAwesome
gulp.task 'fonts', ->
  gulp.src (fontAwesome.fonts)
    .pipe gulp.dest 'assets/css/'


# Task Minify-css
gulp.task 'minify-css', ->
  return gulp.src 'assets/css/*css'
    .pipe $.csso()
    .pipe $.rename({
      suffix: '.min'
    })
    .pipe gulp.dest 'assets/css/'


# Task Minify-images
gulp.task 'min-images', ->
	gulp.src 'assets/img/*.png'
		.pipe $.imagemin()
		.pipe gulp.dest 'assets/img'


# Task Minify-JS
uglify = require('gulp-uglify')
useref = require('gulp-useref')
gulpIf = require('gulp-if');

gulp.task 'useref', ->
  return gulp.src 'assets/js/*.js'
    .pipe $.useref()
    .pipe $.rename({
      suffix: '.min'
    })
    .pipe gulpIf('*.js', uglify())
    .pipe gulp.dest 'assets/js/'




# Task Clean
gulp.task 'clean:build', ->
  return del.sync 'assets'


# Gulp requires a default task
gulp.task 'default',  ->
  #browserSync
    #notify: false
    #server: {baseDir: './'}
#gulp.watch ['*.html'] , browserSync.reload
#gulp.watch '.scss/*scss', ['sass']
