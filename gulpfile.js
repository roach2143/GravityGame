var gulp = require('gulp'),
	express = require('express'),
	path = require('path'),
	plumber = require('gulp-plumber'),
	livereload = require('gulp-livereload')
	sourcemaps = require('gulp-sourcemaps'),
	coffee = require('gulp-coffee');

var server = express();

server.use(express.static('src/'));
server.use(express.static('.tmp/'));

gulp.task('coffee', function () {
	gulp.src('src/js/*.coffee')
	.pipe(plumber())
	.pipe(sourcemaps.init())
	.pipe(coffee())
	.pipe(sourcemaps.write())
	.pipe(gulp.dest('.tmp/js'))
	.pipe(livereload());
});

gulp.task('default', ['coffee'], function () {
	gulp.watch('src/*.coffee', ['coffee']);

	server.listen(3000);
});