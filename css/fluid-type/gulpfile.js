var gulp = require('gulp');
var sass = require('gulp-sass');
var browserSync = require('browser-sync');
var $ = require('gulp-load-plugins')({lazy: true});

gulp.task('sass', function() {
    gulp.src('./app/scss/style.scss')
        .pipe($.sass({precision: 10}).on('error', $.sass.logError))
        .pipe(gulp.dest('./app/css/'));

});

gulp.task('watch', ['sass'], function() {

    browserSync({
        logPrefix: 'Coherence App',
        notify: false,
        proxy: 'http://localhost/app',
        port: 8081,

        files: [
            './cohapp/app/scss/*.scss',
        ]
    });

	gulp.watch('./app/scss/*.scss', ['sass']);
});
